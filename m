Return-Path: <linux-kernel+bounces-873879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1ACC14FAE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E10064FFAA6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11405227E82;
	Tue, 28 Oct 2025 13:49:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457B9218ACC
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659372; cv=none; b=kktLLn9yLsItnIjY3z+3a7Cktt/HjK6gNzQhDF2mLe6ToUcUaVpr+LhmUOJGT1r2EgnEVEBFNpYaIw23uqNT1sJzBLiRIQgVuhqpaLQFJXbllvKJ3Y6Q8HaDFkujVBHKBZktq3Ldae+NHXphAwWW2uxcrkbJz7a8A05OEjezVNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659372; c=relaxed/simple;
	bh=qydsrg9DzwE1II5DrJN1ds7pfRcSxEqPV+4GH57S+2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A9aAvU4TlbgXIbR+E9+DxFylT8ePUok0kpt6ryKCy4o0cv37BsvlQ2vTwwhNtryVdTluQU+BlSCARGniCz38dDsCchWQVEv5xjwaMs7zuK3KAZNST1zS0WzKdtTq2lWMT4ybN648yjoHJpPwh/laoRtKaNo91tZt6xopNmiamxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5995168F;
	Tue, 28 Oct 2025 06:49:22 -0700 (PDT)
Received: from [10.122.4.165] (unknown [10.122.4.165])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F9573F673;
	Tue, 28 Oct 2025 06:49:30 -0700 (PDT)
Message-ID: <13f227a4-232b-4089-b12a-c6e4752ab445@arm.com>
Date: Tue, 28 Oct 2025 08:49:29 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Warning: drivers/char/tpm/tpm_crb.c:193 function parameter 'loc'
 not described in '__crb_go_idle'
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
References: <202510241542.hFrped3X-lkp@intel.com>
 <e1d1ffc0-dda5-4501-8bd5-e4e7ea667f10@arm.com> <aP_Q4XCXnBw4Wv0N@kernel.org>
Content-Language: en-US
From: Stuart Yoder <stuart.yoder@arm.com>
In-Reply-To: <aP_Q4XCXnBw4Wv0N@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/27/25 4:06 PM, Jarkko Sakkinen wrote:
> On Fri, Oct 24, 2025 at 12:43:45PM -0500, Stuart Yoder wrote:
>> Hi Jarkko,
>>
>> I have sent a v2 of this patch that adds the missing kernel
>> doc info that triggered this warning.
>>
>> Thanks,
>> Stuart
> 
> You need to create a separate bug fix of it.

Done.  Patch is sent out.

Thanks,
Stuart

