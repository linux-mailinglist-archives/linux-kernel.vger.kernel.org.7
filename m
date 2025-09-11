Return-Path: <linux-kernel+bounces-812585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34BCB539FB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F50816DD63
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F66935E4FF;
	Thu, 11 Sep 2025 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLWybwoC"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F532376FC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 17:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757610501; cv=none; b=MHq0N8DlpBmQXsRuQ+aRAz+KarnUtamb0Y1yu/A0X96yFedhZImlS2aQVG7PQaRu6Au2/G/3HXXkr1dbLvuJcWWLSpPA6OT53j2wE4hGo1ukorSAeQMo/9d/nxIvvLLXfAhmZOFzmrkc97X4wYPOoTi0s/aPh/CQ8E2eCJKzGm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757610501; c=relaxed/simple;
	bh=rrP7YnwH/IAjRl+5DLVAVWNnRqo/qKVT+Hje3JGkSIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uflE+jxM7re2W6xDF9hJkTJYtjYR3WFehkmCutTTVXBo2L++w5GS7cefeOY909G8A4n0iNcrBaP4tJsbwWmS3MoA6fT70QDPrh69+D3g+bVFR5ia+2ugjvnV6PJviQv3woatkG5vk7Foj+V0bUl59OycdoEDYS4nwDNLJB+iX/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLWybwoC; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-570088480f7so53279e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757610498; x=1758215298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XYWrG/z8ntkohSELJJmfw5BJR4ViX4520Shju2hmuss=;
        b=VLWybwoCHmaNf6fDCoEZffR1qTKowZy8BZUrdPcJAd8w+AxjKLqhSsRZhZOzOUDc6s
         CVFNuLVdEwvX2qtAJfhzBH1ZfOpDNFD+OvHpbVWdiYFdPNUtmnW/uWdqg47mvLWwdNI2
         Qia49z+rwueKND6XkAlNWdD25cwVXrXOgpqRO3wOuZo7rStFjU/a7BSjSCzWidLr2U4U
         DbWKZdCtBaj6MVsM822NWDA/PMWahxdRjAKhlC03KACcJiGILlttWcQDVeu+okZKkfG3
         7pmWSrNo+pSLhDYawnKAB5oeKQo3Agd0zqGjOl6Ewy0mphqXP5+JoQUXfJbaIvT+5K6m
         XyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757610498; x=1758215298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XYWrG/z8ntkohSELJJmfw5BJR4ViX4520Shju2hmuss=;
        b=nh5Zxpid83YtPx9RigdzlW8tkEkG0Vbn5DbGfS1vSutUuWJuIV0HQoZGo3uphqLZBw
         xEU4zzYifMFMdlbrzsFjZpwqtW9LIqHzQh4DKxc0QDCZvroa0fNcT1koE8PiopXSTF7E
         TijlzQ+N8LAeq5cmD7WzsDw/yD+XDxBeL46e2GadTxBYTcnIdWF0mkVNdncKLKc7NoLb
         qLkOtO3WsclZ1RbljeS2nYoKSSfHu4SUzu/buPdujOBvJ8TjvpqBQ2k3DHnN/JijtzSU
         Idv/TRayCZWti9vjc9TPjUldQWYMOdXo5rlRCe4WVzSpMobDywEm4NOgDj0DnbBWJyd9
         5IVg==
X-Forwarded-Encrypted: i=1; AJvYcCWXbxNn8W5EbV3idsSL4Fgvs3Dxs0OLZGpA54nYEaUuvFqCpSA30Mvaai88cyieCuEoEW4UwvZ4rXyrLlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+onyyo35beC+XVHZSBar7M04aKD72xyjLf/jzLcEPZDSwruuv
	vXUg5zvTnksVNW87pl4a5Aj8o3i3A27UDN1PjCdh7B1Xvud+EpniJeP2
X-Gm-Gg: ASbGnctd848/4SkjBg1iv8g8ZmFf/81EGJL3HjdTDO0M0+4Gra7suNkhGxb5ZE30OYC
	nl96y+ulZl0rc25t5cyWA5ofkLWBiumbeZ1R/hSTWBF+SDV+80iopk6Z0aePQcyX8Gg7sPDlbaL
	1Ib7ZWe5X8zDl8g+crKzmluDH3PHcozx55OiuytG1pIy+6T/z1egkFnNVmWDD2RlWVsBCJx9SGZ
	N20i5ENovTKU/p4gVNy/QiGYh8XidvBEVp4KyBswHPU9rl6kT4PM2v22g7F/6lEVixP94Ufnloo
	ZLYawM52HQpK0ipHdN/YG5dPkFZUCHhg4aRIMxYzkGhbPwVokgbmfXqKUAOtMOedh+etC/qcF8H
	1R5MUT346c4pwdJ089VUZVExSUZaV06dK48oxV3s=
X-Google-Smtp-Source: AGHT+IGkRq1b+XclvjAfbrp2HdIg4dj29v/UCbMXdq6x0LUwuyY9G012qPLCEJ36wPGT4HRWuf5+Cw==
X-Received: by 2002:a05:6512:220f:b0:55f:7066:ce94 with SMTP id 2adb3069b0e04-5704a8b3a0emr33427e87.4.1757610497376;
        Thu, 11 Sep 2025 10:08:17 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e65754a7esm516306e87.131.2025.09.11.10.08.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 10:08:16 -0700 (PDT)
Message-ID: <d74e67e0-2ba7-4af8-a207-132ba634781c@gmail.com>
Date: Thu, 11 Sep 2025 19:07:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] Documentation, kstate: Add KSTATE documentation
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Andrey Ryabinin <arbn@yandex-team.com>, linux-kernel@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>,
 James Gowans <jgowans@amazon.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-mm@kvack.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Baoquan He
 <bhe@redhat.com>, kexec@lists.infradead.org,
 Pratyush Yadav <ptyadav@amazon.de>, Jason Gunthorpe <jgg@nvidia.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Rientjes <rientjes@google.com>, Pratyush Yadav <pratyush@kernel.org>,
 Changyuan Lyu <changyuanl@google.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Chris Li <chrisl@kernel.org>,
 Ashish.Kalra@amd.com, William Tu <witu@nvidia.com>,
 David Matlack <dmatlack@google.com>
References: <20250909201446.13138-1-arbn@yandex-team.com>
 <20250909201446.13138-8-arbn@yandex-team.com> <aMDMHx1spjeETKK4@archie.me>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <aMDMHx1spjeETKK4@archie.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/10/25 2:53 AM, Bagas Sanjaya wrote:
> On Tue, Sep 09, 2025 at 10:14:42PM +0200, Andrey Ryabinin wrote:
>> +There are _V forms of many KSTATE_ macros to load fields for version dependent fields, e.g.
> 
> Escape the trailing underscore (i.e. KSTATE\_).
> 
>> +Addition of new field can be done as version dependent field by using _V form of
>> +KSTATE_ macro:
> 
> Ditto.
> 
>> +Subsections
>> +-----------
>> +Another option is adding subsection to kstate_description. A subsection is
>> +additional kstate_description which linked to the main one:
>> +
>> +struct kstate_description test_state_v2 = {
>> +	.name = "test_v2",
>> +	.id = KSTATE_TEST_ID_V2,
>> +	.fields = (const struct kstate_field[]) {
>> +		KSTATE_BASE_TYPE(i, struct kstate_test_data, int),
>> +		KSTATE_END_OF_LIST()
>> +	},
>> +};
>> +
>> +struct kstate_description test_state = {
>> +	......
>> +	.subsections = (const struct kstate_description *[]){
>> +		&test_state_v2,
>> +		NULL
>> +	},
>> +};
> 
> Sphinx errors out on struct snippets like above:
> 
> Documentation/core-api/kstate.rst:17: WARNING: Inline emphasis start-string without end-string. [docutils]
> Documentation/core-api/kstate.rst:17: WARNING: Inline emphasis start-string without end-string. [docutils]
> Documentation/core-api/kstate.rst:21: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
> Documentation/core-api/kstate.rst:28: ERROR: Unexpected indentation. [docutils]
> Documentation/core-api/kstate.rst:32: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
> Documentation/core-api/kstate.rst:33: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
> Documentation/core-api/kstate.rst:84: ERROR: Unexpected indentation. [docutils]
> Documentation/core-api/kstate.rst:100: ERROR: Unexpected indentation. [docutils]
> Documentation/core-api/kstate.rst:102: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
> Documentation/core-api/kstate.rst:103: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
> Documentation/core-api/kstate.rst:106: CRITICAL: Unexpected section title or transition.
> 
> ...... [docutils]
> 
> reStructuredText markup error!
> 
> I have to wrap them in literal code blocks:
> 

Thanks, I will make sure to check that the documentation builds next time.

