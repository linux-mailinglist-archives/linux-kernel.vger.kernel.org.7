Return-Path: <linux-kernel+bounces-837704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBB9BACFEE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFA17192652D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF702F7AB9;
	Tue, 30 Sep 2025 13:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KocRPIlw"
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0FB23507C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759238190; cv=none; b=tyJE9rJcW+VUD3nXaZEjlTU6mNIqhtXFQh+aqs1+yxGR61JVuF6VjVon0yhGTRL/C08mG2MysaAQdrfUZpMGAXf0B+2jD3kFnjiYLcup+Zy8h9o8KXCHzfGDhUGFRPRu1Sb5c1gNO0qOJhL3egMWYGSaM7xX3vU2xupaZQz2LXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759238190; c=relaxed/simple;
	bh=vACPcvX4LWehkNCn3avFNQCRel5Es4xLtJf1RFoWwxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VLcivRcbFHeOM9DMoKUwRJ9YoZrz5us8AWjLazJYpAf/nWYGz+Nb1Y3sxcf+PpmtyX1etxBCziV8M5JkA31JCMtrM8OIpioxUrkYPR2rxlSdSHeatoYY2OgSHrvJfbbg410Dc1KVd0iecwaP01NoejqYP71CEecrcibvAkqJa38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KocRPIlw; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-421b93ee372so1156183f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 06:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759238186; x=1759842986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gdligv9Yrmq7/rk+Qyvy0jU8vW9q2hQx81H/VG9HIsk=;
        b=KocRPIlw32P6U3ZSi8FlWHtZjlLQYLWQZxha/GFDnrwhR7DQjO2ko/u9pNBUVFPdwr
         hmA50rCe38YuqPbzMdXIAnYw1UKEDUZQ7BecZ+JM9qvrbOwIF5UyzEpoB61/eoyuAI/7
         r5wOC2lFXYTuu7QXc3tg1O783qwOGTJfWqJD7c54mCla87VEIngn/1ISu12GjTmOzMiP
         kLKfQ4H5/j1GOq1dRhVUfGyV7HkldA+cySr3oP/jCc3W5dgCLfYRufa2HpK86PUAmpoB
         rVXOCaUc0UymInblrwjt4iNid/WlHyKGqIVTxUlsyas/+oYfP+k5bzpGTJHg29WR4z4X
         mopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759238186; x=1759842986;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gdligv9Yrmq7/rk+Qyvy0jU8vW9q2hQx81H/VG9HIsk=;
        b=HQMDIbz6DsAAtD5JSu4it0e6u5fNSAaxKxjPyiNdcxvhj21zM905/EJLAiUq+iXZti
         MzGwhR+8RKEjum9ZsdK+ZbZcamITPOfyUmnlXH+F96uEYHoJ+SAqzW4bOjyvCqB9CAPa
         T7+cfsHsvL1hlWolLjR988VScFgr3AqDdtubR/3UE6jhyI286VTalCAI7XfhEi7S4LNF
         DlPlO3YG2FJ6a8ffSXgqD6yFU+nHWPIWjVCNgtoefCh7KW9aRIEVULJuDFykN9+Z1dB9
         GqOUreweXIoZqRyjGpSdZx9u9/aiO6AXZofcm76C1mQmRgOgRcUgI9Xco8dEqwIsuO5+
         sKJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCMk/nkUonOuH89UFLPM0pEXDUcV774YaP49nHyX45w850bch1ADOLb7YAegjtqiUb7MeV0PXseIBKpbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRqdYSMgXVGOhY/m1QbfhNe1/Zwi33yeXW/klhLanMPiqiBx7a
	D3cJIATMuQaSrqOyYgLE9+N83nAFd3rGcHfEQULQaC7NoQbNqUwjCjI1Lo2SnFKgonQ=
X-Gm-Gg: ASbGncu6bqsoLYgU1yNcDCNfhyIjhYoamQ4ura1Xdmj3ZnkeF6bFDdwf0H69/7dKcVl
	/YH0jV9nbztQVi+Fvag8DvASYI6XF7ZhQX39BtlL/SBy/gQ0B/ib21R7Tk0omOJxjAguCmivL4h
	uYKPxb2yzs50yVEiEumYvpz9N/D/8oYQFdlIKq4dO1+n1FC9W8qLRAiaTlxQlXOFKaeJjXMhZQT
	pIMcgEmvGnSIIr+MhuSQxru6e8oXb5U98+EGdPgwPD7UPxA8iavO9gehJ+iYCRiqKpXKR/H0mAV
	Vv9MAc/VnBbTO1BaO+ogl1akR9GeZDag2w8Mf+j7ssAaMO2v6ZlropY8kAWLstFm1lx1Iami3tc
	cbqpou/HTriy+xZhPwFTgN6ZILG/QNy8pOXLxxkhJFC+L+S7hAfDllG/CMm7KevMRMmI=
X-Google-Smtp-Source: AGHT+IF1ErbbbjhopZL6pCF+T2Bztzzvt3Govsbo7Ke9CGLKtmmw2H4ZbQVixK6pD842k6HiDc4iKg==
X-Received: by 2002:a05:6000:2507:b0:3ee:1118:df81 with SMTP id ffacd0b85a97d-40e4623732amr18897288f8f.13.1759238186177;
        Tue, 30 Sep 2025 06:16:26 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fb2eesm23337471f8f.12.2025.09.30.06.16.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 06:16:25 -0700 (PDT)
Message-ID: <3fc3f7e8-3297-4586-91ca-41f07c8a9418@suse.com>
Date: Tue, 30 Sep 2025 15:16:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] module: enable force unloading of modules that have
 crashed during init
To: Julian LaGattuta <julian.lagattuta@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250918201109.24620-2-julian.lagattuta@gmail.com>
 <000808f3-10cf-46ad-94f9-95a142c08b59@suse.com>
 <CADuX1qJZ1V32d0U4hSOUOzte2KE-k-Hzop0zZd4=7Ap-kS3JzQ@mail.gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <CADuX1qJZ1V32d0U4hSOUOzte2KE-k-Hzop0zZd4=7Ap-kS3JzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/25/25 12:16 AM, Julian LaGattuta wrote:
>> Could you please explain the motivation for doing this in more detail?
>>
>> I think we shouldn't attempt to do anything clever with modules that
>> crashed during initialization. Such a module can already leave the
>> system in an unstable state and trying to recover can cause even more
>> problems. For instance, I don't see how it is safe to call the module's
>> exit function.
> 
> Thank you for your response Petr. The motivation comes from when I
> wanted to replace a crashed module with one which does not crash
> without having to reboot. I looked around and saw some other people
> complain about it on stackoverflow.

Hm, I'm still not sure I understand the use case. If it is about being
able to remove a crashed module when developing it, then I wouldn't
expect rebooting the machine to be much of an issue. If it is on the
other hand about removing it on a production machine, then I think
attempting this can leave the machine in a worse state and not something
we should encourage or support.

> 
> I thought that if a module crashed during init, it would be in a no
> better position compared to if it were forcefully removed.
> Therefore, there is no reason why this shouldn't be an option as it
> couldn't make the problem worse.

A module can be halfway through its initialization when it crashes. It
may have already registered with various parts of the kernel and
I believe that removing the module from under the kernel's control could
result in even more problems.

The current support for forcefully removing a module overrides the
kernel's tracking of module references. This option was originally
introduced by "[PATCH] Forced module unload" [1]. As far as I can see,
it was related to the module loader rework at that time in "[PATCH]
In-kernel Module Loader" [2]. This rework provided raceless
loading/unloading and marked several MOD_INC_USE_COUNT/MOD_DEC_USE_COUNT
interfaces as obsolete and unsafe. Since some modules still used the old
racy interfaces, it seems the forced removal option was added to make it
possible to remove such modules.

However, this issue should have been fixed a long time ago, so I wonder
if even the current CONFIG_MODULE_FORCE_UNLOAD support is useful.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux-fullhistory.git/commit/?id=d0f8c9a4c2c9d93463d157248c73028670e80a97
[2] https://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux-fullhistory.git/commit/?id=4c877b08daf4b463c144cbd2748ed1659931a0dd

-- 
Thanks,
Petr

