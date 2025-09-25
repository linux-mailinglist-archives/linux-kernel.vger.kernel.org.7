Return-Path: <linux-kernel+bounces-833077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5746FBA1283
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02ACA3A5E72
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D54731B82F;
	Thu, 25 Sep 2025 19:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IrYgpZpR"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D920425A352
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 19:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758828229; cv=none; b=R4gQ29d4J1d9uX9MHisimcOOLZpiDRBsPUXEt93lAXrLeiOCofSjIhfEpKGCf5Apm7E+1w4ykaMYaSkGsHqLw+FpFAy0p/9oBtDvcWgD1P5KIdwitOk2VqpleTNRBuLrUA8D6bWDtJ4VijjF721vRXsqZf9tMbs8jQuKCTPevBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758828229; c=relaxed/simple;
	bh=SlcgX4N0sT/oAXGKeqfxd72c1+OLj1emBHILemBx3fA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qyZGsVHIpSJbEN4w5f/9DxmBQ0O2sRNWPnM0CJ94Uoa6+vKVPko7XCV3O3AeDkhVRuITeCqpJN8OSFHrK+3wiIDcw6L33GhFw+L1P1I4nwJLp5DixwAnVXbRdYDhmx3/XtDoK2l5R7ZDWgTCaHY9WJ0RKE5YiQHDq1YPsMKC194=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IrYgpZpR; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-621a3c43df3so710867eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758828226; x=1759433026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u4KMcB5gPgh88FQEiiX6SUAlDyQQTzfhsAxtb+o4J7o=;
        b=IrYgpZpRG1Znqezmei0zDxXNpdFr/fIZ0GGi7wPya4ZVmKEFL2G7IT6oCw9cEnP1md
         5mvho159o2LDS3Lc8WlAY42g6EHYmJrwySgqPRBNzFJQokS2AuOH7H8UiNgEU21CoNZP
         ZT34Ii6JEwSRCTGV/OLbYt6c2fkAx/KIbylJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758828226; x=1759433026;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u4KMcB5gPgh88FQEiiX6SUAlDyQQTzfhsAxtb+o4J7o=;
        b=Ux2oKN8ZlFAlaSA3VQ84aExZnQggvdz3/g9qoRxrmRFIjxaJg0Qich4qI20RyUhDLd
         C5pIZWaSzU8lN//rAdgr0c3J55RyQro5AJY9c1kjfnKcs3JjbwSjUDfQ9xGKbhUk6ldF
         qmzINnnA+/lraMsyfyOljy2CL7agU4CKQ11w0RfnDvs/5U4qDZOt1Mr4bOn+n+BoY/69
         KPG3A9weHEEOehEVDjZzg1dejLrbK4aXf2Gd6P58lHZoJvQEfF388VTQU4KF9RYAUovh
         bVMFPu+5rg1Vyh2LDGNTOAvSfLLgJdrNXZAkNvay0Fe16iC/2td/s7t7E7u4f/bDwHi8
         Re/g==
X-Gm-Message-State: AOJu0Yzf223n/uWHfpu8prCAhyS/2yPurb+mJDf/Z7VMTIZBgMe67FVv
	zPzILpxfniO3OYZfUtAUdcHxh18seNETGsRGEG1DV5sAYPpaf73gqb77N2jpLlqSJtHU+8EFsIP
	AHosO
X-Gm-Gg: ASbGnct7FWpNcnUCh0NB6tMEwNp4mu0FeF3qEOwNjYplnrYd2Rtr3uMXnjl7OnuxScm
	CNGqInxUm0ak0J23gYEpiBYX87dV1vMUjJidDcDsD79k4ooVgttVZ3FrQ3ufVvm/GEE+Is32VlP
	bnrbMsPVQMoMsDRYoRSX+lzAAqO7oNfVoHGFgNPBCdvTI7hPGiwduQoSYM9Y9OlUVUeh53/jSBu
	pUcLlV6YpoRO/9sl4QqezumxB89nU0p2QXXHK+RHeq5q4PJqDDVxtlolD8LqW4Rfeq/1ofnJjae
	Ei0wjzseK+wR9zTKeDgG3h85mwhhRk5MG7SJLaq1cE9E+mC9aRH46daXihoxNvWrX9baO/HohSp
	J7YTA3ssESwARs75XK6HLV1VuMfgYZZ9NwQA=
X-Google-Smtp-Source: AGHT+IHA1OyuHnLSdTTrF5+wUswOWVcuJY3KaVBScT10A5tAdHoQNHqXJsVDvusdIQAv4smHLolaxg==
X-Received: by 2002:a4a:c588:0:b0:63d:bc20:a61a with SMTP id 006d021491bc7-63dbc20b6bfmr543382eaf.7.1758828226054;
        Thu, 25 Sep 2025 12:23:46 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-63b28448e7dsm300861eaf.22.2025.09.25.12.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 12:23:45 -0700 (PDT)
Message-ID: <fd575fd2-f246-469d-9276-bb746b554e19@linuxfoundation.org>
Date: Thu, 25 Sep 2025 13:23:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] selftests/acct: add cleanup for leftover
 process_log binary
To: Madhur Kumar <madhurkumar004@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <d8df684e-0c09-44ea-87a4-cdbaf65ab0b8@linuxfoundation.org>
 <20250925083445.172571-1-madhurkumar004@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250925083445.172571-1-madhurkumar004@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/25 02:34, Madhur Kumar wrote:
> Some kselftests generate temporary binaries that are not tracked
> by TEST_GEN_PROGS. Add EXTRA_CLEAN entry to remove process_log
> during `make kselftest-clean`.
> 

This information below doesn't belong in the change log

> v2:
> - Fix newline issue at end of Makefile (caused add/delete in git diff)
> - Code otherwise unchanged
> 
> Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
> ---

Add patch version information here.


>   tools/testing/selftests/acct/Makefile | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/acct/Makefile b/tools/testing/selftests/acct/Makefile
> index 7e025099cf65..fd14128bbddb 100644
> --- a/tools/testing/selftests/acct/Makefile
> +++ b/tools/testing/selftests/acct/Makefile
> @@ -1,5 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   TEST_GEN_PROGS := acct_syscall
>   CFLAGS += -Wall
> +EXTRA_CLEAN := process_log
>   
>   include ../lib.mk

This line below is still odd.

> \ No newline at end of file

Start without any changes, make the change, commit, and send
v3. Refer to a few patches on the mailing list for examples
on where the patch version information should be added.

thanks,
-- Shuah


