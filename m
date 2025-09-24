Return-Path: <linux-kernel+bounces-830112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4B9B98BED
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 220F74C428B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4874728643D;
	Wed, 24 Sep 2025 08:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ufqev9/0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9010325A34F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701120; cv=none; b=N8aQeyCL/4naqP1SrqFQlPQrVcetKULfX6b/TbauduxJILtx1Q2J7nvvnhoXUXwc337gDTTJfueZVdHqCHAcAFUQzJdpn56XZMOWX5pdzVMaQKfBrfq5uZmM1CafS5YnUMC7Bxi58PzBQ57AQPWTTLYJFB4/Lsfr+HsvsngROoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701120; c=relaxed/simple;
	bh=crF6Az1YSgLdU9XhdJ1KkmiF1PxZyJXrk5Vf93YEvks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZymLOPssqK8xD02ofH+NXH62LkGFovxpYLjrisJjpjh7eQ2boDhPl+pSif5OLrwW7Ef8XB1IM1+kjfH5xgjV6nNLNPrTj7kOsHsk2wcaEgtYgqzR+SbK5fBJpAr0j9lgT5VmUAL5mhvLYQzCgPPA76fYsh3j4D3GAw30qPu143I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ufqev9/0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758701117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lE0jLBwj6v5RJ9sfXT8HYz8ot+vmwAivygaeoOEjH7w=;
	b=Ufqev9/0nfnST+k0I4YZbk2h5XYSQezjTVGUniwQ4g/6HL48BJLqQTItK+YtJpivQ2BUbz
	bwMBa7p/rDjKW3IHHWdznoY003QNizqAYxqeky2raVCmfMoraBc1tGAXUD5s2CISh1hNcS
	e7C0cg3pk6SFJ8XWSEgqax6YTNqC+Z4=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-zWe3iacJNGGy16fTr938EA-1; Wed, 24 Sep 2025 04:05:16 -0400
X-MC-Unique: zWe3iacJNGGy16fTr938EA-1
X-Mimecast-MFC-AGG-ID: zWe3iacJNGGy16fTr938EA_1758701115
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b4f8e079bc1so4584120a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 01:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758701115; x=1759305915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lE0jLBwj6v5RJ9sfXT8HYz8ot+vmwAivygaeoOEjH7w=;
        b=j27d57uR197sU1W7vY8Nn6ADFnvMgaFgNSdJ9NOG0hWuPUQHQZ5HyOqQi7nKGv4CK+
         f4Ax49I60pTbuuFPqf833yE8Jv+bP6RhP6OtdJZiaYdXi29RNcMJuxAmVaVZ/8fHVXvr
         fqr/bKF6VTlT9XRqpx9i2gOij/LSnjhwDUSFn9wKaDbTJHziSBr+OXeeonSIu/lG3c8S
         EKwHLp+GottlTZlAsx20qToslokkFm/TvORKqdiZAGwY6qmAQCXnE+VmVIfr1zV8z7tB
         1iof3w4S2w5yh9pF99EZkKDYyJT2pzxaG4Q72StAkH0te4ndTcO2zVKFTzq/ZkWnY6if
         oIww==
X-Forwarded-Encrypted: i=1; AJvYcCV63bgspBwIYfLpVgMFA2kZWvEEjMbQ97DaAiZWvco5l3e8D5ljtMGYs6T2EFFjYBteP+6HKqC4rzH7Q5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3/+wHz7ye/xTE9ECt1EuTCw11IKCj4d4iLPAB51RmZa6b13AS
	/RaZrWCwtROJThGsQpFhfovcdqEBrSgZ9aKBmLi8PM7AcymQufP1JTsLpJfMJvD+uEd82muVRjA
	vDFwKl2Fzeaquqd1fj6c5rU4bozmjJlu5W3wXUfwSkgJEu/cjFhO356T9dICSOZx4z4bwe6QNNh
	/Ui78=
X-Gm-Gg: ASbGncuEL+I/uyfmoNwhEy2TgVfg95zheP+qTX0Tni7ixqVYwCAcLdMvThf/xCaF0Z/
	eB/5JKh05KCiEWWec98R3WgUfhtBxdgHD5I8UMu/TmILOIqKL1zeyFuzsmjNIx6T0WPzVdom35M
	c8deVRNjtvEUHbaoMtlfKmMLt1R/YlaAnSgKZeZuAoh768RGvl2GGnE3WQlICVuBcgp1cL7o9si
	5Y+t80Sr0Nn3TDtIskmAkVysdKU322ZczGBXn83jbmId981QvI6rTOlJVg3KrwZm1lN/vfZ2JQ/
	kf1vXTch38CZ0JMumm7hd6JmmcSzs9c=
X-Received: by 2002:a05:6a21:3395:b0:263:4717:564 with SMTP id adf61e73a8af0-2cfddc69ce1mr8313157637.6.1758701114633;
        Wed, 24 Sep 2025 01:05:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGuhOhnDnh5hDS01MfzwD+uSDir+osMndP2WHac8aNDoTYljhwk/oMLyIc2NRJK/sfRtf6gQ==
X-Received: by 2002:a05:6a21:3395:b0:263:4717:564 with SMTP id adf61e73a8af0-2cfddc69ce1mr8313098637.6.1758701113951;
        Wed, 24 Sep 2025 01:05:13 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b551518480asm14410381a12.28.2025.09.24.01.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 01:05:13 -0700 (PDT)
Date: Wed, 24 Sep 2025 16:03:34 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ima: setting security.ima to fix security.evm for a file
 with IMA signature
Message-ID: <4l7l4duxfximhzixruim3lnij5mhnlqs5srzycc6j6c2bu5zda@ogoj3ade37fd>
References: <20250909041954.1626914-1-coxu@redhat.com>
 <5aeecf1aa6eff8ae0ea0a9e95d5df79aee338b32.camel@linux.ibm.com>
 <r3himk4z2aiyqsjstlpnda4wafeo7i4oum3n2dbvnasmtep5ex@zqodcpjmyx5b>
 <40e9c7bd15d4ab8b71ac335b5d896ed39c61980c.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <40e9c7bd15d4ab8b71ac335b5d896ed39c61980c.camel@linux.ibm.com>

On Mon, Sep 15, 2025 at 05:05:42PM -0400, Mimi Zohar wrote:
>On Wed, 2025-09-10 at 09:20 +0800, Coiby Xu wrote:
>> On Tue, Sep 09, 2025 at 11:31:20AM -0400, Mimi Zohar wrote:
>> > On Tue, 2025-09-09 at 12:19 +0800, Coiby Xu wrote:
>> > > When both IMA and EVM fix modes are enabled, accessing a file with IMA
>> > > signature won't cause security.evm to be fixed. But this doesn't happen
>> > > to a file with correct IMA hash already set because accessing it will
>> > > cause setting security.ima again which triggers fixing security.evm
>> > > thanks to security_inode_post_setxattr->evm_update_evmxattr.
>> > >
>> > > Let's use the same mechanism to fix security.evm for a file with IMA
>> > > signature.
>> > >
[...]
>> > > ---
>> > >  security/integrity/ima/ima_appraise.c | 27 +++++++++++++++++++++------
>> > >  1 file changed, 21 insertions(+), 6 deletions(-)
>> > >
>> > > diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
>> > > index f435eff4667f..18c3907c5e44 100644
>> > > --- a/security/integrity/ima/ima_appraise.c
>> > > +++ b/security/integrity/ima/ima_appraise.c
>> > > @@ -595,12 +595,27 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
>> > >  		integrity_audit_msg(audit_msgno, inode, filename,
>> > >  				    op, cause, rc, 0);
>> > >  	} else if (status != INTEGRITY_PASS) {
>> > > -		/* Fix mode, but don't replace file signatures. */
>> > > -		if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig &&
>> > > -		    (!xattr_value ||
>> > > -		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
>> > > -			if (!ima_fix_xattr(dentry, iint))
>> > > -				status = INTEGRITY_PASS;
>> > > +		/*
>> > > +		 * Fix mode, but don't replace file signatures.
>> > > +		 *
>> > > +		 * When EVM fix mode is also enabled, security.evm will be
>> > > +		 * fixed automatically when security.ima is set because of
>> > > +		 * security_inode_post_setxattr->evm_update_evmxattr.
>> > > +		 */
>> > > +		if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig) {
>> > > +			if (!xattr_value ||
>> > > +			    xattr_value->type != EVM_IMA_XATTR_DIGSIG) {
>> > > +				if (ima_fix_xattr(dentry, iint))
>> > > +					status = INTEGRITY_PASS;
>> > > +			} else if (xattr_value->type == EVM_IMA_XATTR_DIGSIG &&
>> > > +				   evm_revalidate_status(XATTR_NAME_IMA)) {
>> > > +				if (!__vfs_setxattr_noperm(&nop_mnt_idmap,
>> > > +							   dentry,
>> > > +							   XATTR_NAME_IMA,
>> > > +							   xattr_value,
>> > > +							   xattr_len, 0))
>> > > +					status = INTEGRITY_PASS;
>> > > +			}
>> > >  		}
>
>Instead of re-writing the IMA signature without a clear explanation, define a
>new EVM function named evm_fix_hmac() and add a call here in IMA. Only in EVM
>fix mode would evm_fix_hmac() update the EVM hmac.
>
>        } else if (status != INTEGRITY_PASS) {
>                /*
>                 * IMA fix mode updates the IMA file hash, which triggers EVM
>                 * to update security.evm.  ....
>                 *
>                 * Similarly, trigger fixing EVM HMAC for IMA file signatures.
>                 */
>                if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig) {
>                        if (!xattr_value ||
>                            xattr_value->type != EVM_IMA_XATTR_DIGSIG) {
>                                if (ima_fix_xattr(dentry, iint))
>                                        status = INTEGRITY_PASS;
>                        } else if (status == INTEGRITY_NOLABEL) {
>                                evm_fix_hmac(dentry, XATTR_NAME_IMA, ....);
>                        }
>                }

Thanks for the advice! I wonder if we should use existing
evm_update_evmxattr instead of defining a new EVM function. 

     /*
      * Calculate the hmac and update security.evm xattr
      *
      * Expects to be called with i_mutex locked.
      */
     int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
     			const char *xattr_value, size_t xattr_value_len)
     {
     }


I already tried evm_update_evmxattr and can confirm it works.  But later
I switched to __vfs_setxattr_noperm because I thought it's consistent
with current logic of adding security.evm when there is already correct
security.ima and it's a slightly smaller change.

-- 
Best regards,
Coiby


