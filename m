Return-Path: <linux-kernel+bounces-809226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3632B50A34
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 03:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C685564C4A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 01:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913601EF36E;
	Wed, 10 Sep 2025 01:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eugDPARi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ADC1EB5E3
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757467519; cv=none; b=fS4jS/Bg1coDENtO4NLMjQiRoVKw5Z93k3G6fkwqVpLPqcVPPsFjcoEvtf9Gwf0HqUg4kD9UsY2g3Oz1tC+LJ8lDR0VuT5USLH+kYsn3mns/UcL4MycFllGacDqeGVo86h8WPXxbzeq0R19HN0N6zLaX74TEahrthfllbl36yQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757467519; c=relaxed/simple;
	bh=4GWi8FJrFdGglwpD+ZM2rzgalHuKfUIMSpQQxJduueA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Huf7Bza+VzhaDbIUdn+DAxyoZQsQJa0FZ7/Dq+JZDZimF79Co/aaLmeVA4QKKGPv8PvaUcaXPKPJ+QI1BXb+8wMh8zig4J9FD25mDj1SiEBJjsaB1AoMcTQV3tldK4Pl+gTabhRzrn8w5MXaXQCPFlAJ3yEVzuc4uRgU8pBamzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eugDPARi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757467516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1S0JMauUdEExgpfNai3TrQujfpxsJzdhy7tT6tsEQaw=;
	b=eugDPARiIuJtA0WzwmHpLKpjaeFE6UZ4PJty2idYfe4RPDBxE0qMEkVJxGGRUEDfLBqLZi
	W+vGrSu411It38qD/wo1jg07bkRAvJQp2MbL6WH2MbPqWDiZmQnWB5tMQUhSealRPM5r2a
	cUgvRNRkf/TOLYHTXMzzXxmUTEFEMfA=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-Smu3-4grNyuV7zoDrgohsg-1; Tue, 09 Sep 2025 21:25:15 -0400
X-MC-Unique: Smu3-4grNyuV7zoDrgohsg-1
X-Mimecast-MFC-AGG-ID: Smu3-4grNyuV7zoDrgohsg_1757467514
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24c8264a137so74471105ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 18:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757467514; x=1758072314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1S0JMauUdEExgpfNai3TrQujfpxsJzdhy7tT6tsEQaw=;
        b=KDMsgJEXbNtxMl65BY1j4PMcl87H2AoIbIgaXDvVWXQwNXj2qoAGICsCylXXwtAPz9
         QHtHjHKdGTngQUEYEHNy0Z4NADLe0wrDHf7owvr7OsKzLfFjIrhRtw1QRo7qkb1KYiEL
         4DFvXpBiqkiY+/c64gf5WNLT9t2TIkevXKj4GFA+QSn4XOBOy4E2wtCQEEWnBb9xoG+e
         Lh5rCxO/+k8nuFFH4w9UBte54mbtE74h0GAhUTY/HXpW0Fz6+Cgvisr1P80iqgLMQg9b
         7HiMkekI9L3j6GwsQUowihnXXFuOTnc6ARCEMnmgJKzfEOVhb+PMO848ZI5jarw1L7us
         Vjbg==
X-Forwarded-Encrypted: i=1; AJvYcCVZYt+dOzPEeGn4Va1//SFazYCuzTsYuB07yKIw6ocezFDYbAnw9cxNaEcOge3bSMoXCakqRGJYH4uDJO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMWyAivlAjb0jF+OT/kaWnxzgA/S8XBOkjNGIs5rydSANhvPu6
	8/Y1KK6T7j2CtUsM5jbodtrJNXjxs0MEHvLSO8hRwaEIPISNnYdZ7/Z/n+lG0jN4YJNP/TxEryL
	0af3UGm3/McZlrTueCGr7/SgsO4HE4Vwtf/yuJb3XDaJ2k3nVtIh90om3yUQeh2zxpA==
X-Gm-Gg: ASbGncv7z0sbL2EYOz40PewzYffONotQkDXWHoXAkqHh6yUG8KfIgjMsguIw7ski1rx
	r+l6DgHnapCIumpAXvK0e+bMYXTL4UFtwUZzNzSpfzRpKItyUSdPhaompLuR2XzH7WcAHwQmMnS
	QhgwS7W94zPGPYdqlJX3mDJaPcsXYvO5HVtOq2a7hjMOfCFv11peQ4YEn0vOxSKeHobw5WKzLVj
	CfuBDqOf9F8DXUQM8e6g3go0Vm9dt5NvGfr0eBKYCrajC8Of6AUQmQPZ+blWsm/RpYaTikH9ET6
	Ne+VgWLoa8RHIgQJi6m/FciSKZgUTK4=
X-Received: by 2002:a17:902:e849:b0:24e:7a4a:ec59 with SMTP id d9443c01a7336-2516dbf1ed0mr157716655ad.22.1757467514412;
        Tue, 09 Sep 2025 18:25:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwc9Y0nnGPtTYZcw0VCtzujxBLCFu6IrQ2CgEWKnSXXOY5vhKnUk+VwzDfNYN9T92gLbLFbg==
X-Received: by 2002:a17:902:e849:b0:24e:7a4a:ec59 with SMTP id d9443c01a7336-2516dbf1ed0mr157716525ad.22.1757467514072;
        Tue, 09 Sep 2025 18:25:14 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662f2fd4sm3336388b3a.93.2025.09.09.18.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 18:25:13 -0700 (PDT)
Date: Wed, 10 Sep 2025 09:20:43 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ima: setting security.ima to fix security.evm for a file
 with IMA signature
Message-ID: <r3himk4z2aiyqsjstlpnda4wafeo7i4oum3n2dbvnasmtep5ex@zqodcpjmyx5b>
References: <20250909041954.1626914-1-coxu@redhat.com>
 <5aeecf1aa6eff8ae0ea0a9e95d5df79aee338b32.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5aeecf1aa6eff8ae0ea0a9e95d5df79aee338b32.camel@linux.ibm.com>

On Tue, Sep 09, 2025 at 11:31:20AM -0400, Mimi Zohar wrote:
>On Tue, 2025-09-09 at 12:19 +0800, Coiby Xu wrote:
>> When both IMA and EVM fix modes are enabled, accessing a file with IMA
>> signature won't cause security.evm to be fixed. But this doesn't happen
>> to a file with correct IMA hash already set because accessing it will
>> cause setting security.ima again which triggers fixing security.evm
>> thanks to security_inode_post_setxattr->evm_update_evmxattr.
>>
>> Let's use the same mechanism to fix security.evm for a file with IMA
>> signature.
>>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>
>Agreed, re-writing the file signature stored as security.ima would force
>security.evm to be updated.
>
>Unfortunately, I'm missing something. ima_appraise_measurement() first verifies
>the existing security.evm xattr, before verifying the security.ima xattr.  If
>the EVM HMAC fails to verify, it immediately exits ima_appraise_measurement().
>security.ima in this case is never verified.
>
>This patch seems to address the case where the existing security.evm is valid,
>but the file signature stored in security.ima is invalid.  (To get to the new
>code, the "status" flag is not INTEGRITY_PASS.)  Re-writing the same invalid
>file signature would solve an invalid security.evm, but not an invalid IMA file
>signature.  What am I missing?

Hi, Mimi,

Thanks for raising the question! This patch is to address the case where
IMA signature is already added but security.evm doesn't yet exist. So
EVM HMAC fails to verify but there is no exiting
ima_appraise_measurement immediately.

And you are right that re-writing an invalid IMA file won't fix an
invalid IMA file signature. And even when IMA signature is valid, the
verification may fail because the key is missing from .ima keyring. This
happens because we need to turn off secure boot to enable fix mode. As a
result, CA keys won't be loaded into .machine keyring. Btw, if I'm not
mistaken, current IMA code assumes we are not supposed to fix IMA file
signature.

>
>thanks,
>
>Mimi
>
>> ---
>>  security/integrity/ima/ima_appraise.c | 27 +++++++++++++++++++++------
>>  1 file changed, 21 insertions(+), 6 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
>> index f435eff4667f..18c3907c5e44 100644
>> --- a/security/integrity/ima/ima_appraise.c
>> +++ b/security/integrity/ima/ima_appraise.c
>> @@ -595,12 +595,27 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
>>  		integrity_audit_msg(audit_msgno, inode, filename,
>>  				    op, cause, rc, 0);
>>  	} else if (status != INTEGRITY_PASS) {
>> -		/* Fix mode, but don't replace file signatures. */
>> -		if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig &&
>> -		    (!xattr_value ||
>> -		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
>> -			if (!ima_fix_xattr(dentry, iint))
>> -				status = INTEGRITY_PASS;
>> +		/*
>> +		 * Fix mode, but don't replace file signatures.
>> +		 *
>> +		 * When EVM fix mode is also enabled, security.evm will be
>> +		 * fixed automatically when security.ima is set because of
>> +		 * security_inode_post_setxattr->evm_update_evmxattr.
>> +		 */
>> +		if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig) {
>> +			if (!xattr_value ||
>> +			    xattr_value->type != EVM_IMA_XATTR_DIGSIG) {
>> +				if (ima_fix_xattr(dentry, iint))
>> +					status = INTEGRITY_PASS;
>> +			} else if (xattr_value->type == EVM_IMA_XATTR_DIGSIG &&
>> +				   evm_revalidate_status(XATTR_NAME_IMA)) {
>> +				if (!__vfs_setxattr_noperm(&nop_mnt_idmap,
>> +							   dentry,
>> +							   XATTR_NAME_IMA,
>> +							   xattr_value,
>> +							   xattr_len, 0))
>> +					status = INTEGRITY_PASS;
>> +			}
>>  		}
>>
>>  		/*
>>
>> base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
>

-- 
Best regards,
Coiby


