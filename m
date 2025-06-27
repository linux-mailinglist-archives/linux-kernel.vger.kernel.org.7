Return-Path: <linux-kernel+bounces-706334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B50AEB53F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 12:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF4F17477B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 10:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091ED298CD2;
	Fri, 27 Jun 2025 10:45:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5534226D4C7;
	Fri, 27 Jun 2025 10:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751021120; cv=none; b=jOPw3eQhvG2e+HoxH2Gd6YEXwAobyfD796Hrzg3LUFJXrHPAkKsKbQGwOfh2zMtYPOafE0PGPH3XD4j0gVCTkONOzoFN+FwdyWZj9HB7pO0FjqJyaULBEJ4OWgUmEbNaeaC6ILsbrtWAE2y8wcgo219bq3fAxYg4dOUBoOMsBg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751021120; c=relaxed/simple;
	bh=rOC3ZN61YB87VOjCKjWidgsmHChsG4gpfO2vqW9HwGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YS8axdIdm/Thpc6nCxxMhjwgtPRH0ZgequvY4x5V42LRTw7GUSZXzoTHxhsLtwNUJkq+TakeABnOUcQvIF5ujsWJaNbHeJL4mZIv/WXJEz8tTylCvkqVI/F5H33o1WGsi9YS7ydlHY3YPUzH0xwIRiq99UJaISVHybjrEXOwnpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D31A1A00;
	Fri, 27 Jun 2025 03:45:00 -0700 (PDT)
Received: from [10.163.36.129] (unknown [10.163.36.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A64A3F58B;
	Fri, 27 Jun 2025 03:45:14 -0700 (PDT)
Message-ID: <af5cbd48-6312-481d-8e91-7739612493c1@arm.com>
Date: Fri, 27 Jun 2025 16:15:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/arm64: Prevent build warnings from
 -Wmaybe-uninitialized
To: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250625020138.3777454-1-anshuman.khandual@arm.com>
 <dd3dee5a-b030-4658-8cef-c777928368d4@sirena.org.uk>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <dd3dee5a-b030-4658-8cef-c777928368d4@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 25/06/25 3:54 PM, Mark Brown wrote:
> On Wed, Jun 25, 2025 at 03:01:38AM +0100, Anshuman Khandual wrote:
> 
>> @@ -96,7 +96,7 @@ static int write_sleep_read(void)
>>  static int write_fork_read(void)
>>  {
>>  	pid_t newpid, waiting, oldpid;
>> -	int status;
>> +	int status = 0;
>>  
>>  	set_tpidr2(getpid());
>>  
> 
> This will shut the warnings up, but it's a bit of a heavy hammer that
> means that the warning can never trigger warnings for that variable
> being unused.  Is it possible to fix this by updating the control flow
> such that the compiler can tell that the initialisation follows the use?

The problem might not exist in reality. In the test function test_fork()
in the file tools/testing/selftests/arm64/gcs/basic-gcs.c there does not
seem to be a path where WIFEXITED(status) might get called when 'status'
has not been initialized as there is a preceding waitpid() which would
ensure 'status' gets set. Similar scenarios are present in fork_test_c()
and write_fork_read() as well. 

But the compiler still throws these build warnings. Seems to be false
positives and this fix just works around that.


