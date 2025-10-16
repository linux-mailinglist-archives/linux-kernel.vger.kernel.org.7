Return-Path: <linux-kernel+bounces-855487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B492BE1652
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 05:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F199C4E736E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 03:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C14A218ACA;
	Thu, 16 Oct 2025 03:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TP/DkKYl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296C1205E3B
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 03:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760586921; cv=none; b=PErikM5YcabdkgWrO/5e/1Nc7LW05DfLfbPJQ7XhGOmzQo4i/bLOsEJNIEKECjT6MPV/hzrQNtHUGN6NClYtUCL/sdMhlgOnSpR1x2G+JTv3/bKaUWoVMOd01ZISNjOsAWtfNHNMss+5/23bCmfVXb3kQ2LzKeuqXNk4P033Qdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760586921; c=relaxed/simple;
	bh=uyz1GY4+vfaKF69cegJW5F5FnUUtXIpdHDZD1SOvAZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENKtOukOfc0ksdGxL6y0YHjo4rNqnXfwglANMUGAmxCv4G+eVWJUfBcYGWeQysre9gRGFIuYggMw5z4DdKvqYSgCZPyw8qhofp4WrmdP7akgGx8kItCVEN85D1TG621p1Cnd2pIqkTffVT6vDRJQN9an/efqTvdBe1n3Yo05I90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TP/DkKYl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760586917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zc86LD6zugfOCllRI8l5UX622RRX/t1Ywr+EQbxvvEc=;
	b=TP/DkKYlckGAlV7oHjh2tpxJZh1ye1od0a56Sw6zRGPth3xGlgYF5uvBFaBXm4WHwzFyGD
	DRuALk1fZE3gG/9TIeipe4nvxqztlGrmuXq4nksTRzfMBbrZvvovhdK2fbX+j+owuOcsuK
	shqa0u5xp1tqQvsY3e2CJgUlEcBRYIw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-InwuW2poMnSzlmdJ8A04Cg-1; Wed, 15 Oct 2025 23:55:16 -0400
X-MC-Unique: InwuW2poMnSzlmdJ8A04Cg-1
X-Mimecast-MFC-AGG-ID: InwuW2poMnSzlmdJ8A04Cg_1760586915
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32eddb7e714so313242a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 20:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760586915; x=1761191715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zc86LD6zugfOCllRI8l5UX622RRX/t1Ywr+EQbxvvEc=;
        b=gkmskT+YngrhokE2Nf42OGNtrDIf/6kzsZXwsAnhtQwo4aB7IjqIVAI+N+5KY6qQb5
         i8RIrLqjAZD/BSUH7A6i5BsCYrsM3/0TLpeTINWSBWepb7jWLjgz3ztR/h6OmVBenyAN
         j8Prjm4eYVIGE+q8yD/H4ZMdlfEc6YO8IzzeqUf49F06S+H09pxno8QjZYz9tDMF0rg0
         pDi3fwmGy7FBWVLWawWE9xJpq4k+MNF3z/dvyw1ZThiFJWfZSozntNexcEGl4O5rJG1l
         uAPcmvOv8Ed+bf+db455MmgzKYanLvUp/9C7uG6v2Size2v+BoP7C5HovF137kymJ2Ef
         QAdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6KJqjXtXQDnqkf/OnfnUt8p4UTc1dvmmxZhi7ZZTOwd6mKszHfMEuWe50Kn4MwJU2ICRArEhyTJWWOec=@vger.kernel.org
X-Gm-Message-State: AOJu0YziGFST4+Zlecb1tcA9XhGyaj4f93QTES9ZM0LbELHcKOvpMmD4
	0x+u8B5mH+RCF65fFOgTQUiTtIStuvnvEf5fgp/hqHBwvbCspscXQnPY8oaoo5fvoJ5oIGUABei
	fQX3DywuDF61E8hYEkJno20G02ZOjwnuK9D4K/nI+9ODy+kqjoxNrXf5ISAp05kZPyw==
X-Gm-Gg: ASbGncu8OJMpUrIYY6zUNI2C731j04Avg3PzEafqrMuCgYD5ml5K/j41/ouYoI+iI/b
	NfI5doFINEq1VwlRQDqrOBuMZM9YoraBmfGKR+np6IO1nBkRdQ3DpvR7gZ+reRxrthriWTCU5hB
	kkWu3C6j9qWCNS2RjOw0G4u1O0EutOsLpy2E76IGOTuJziazXUXUpfeAQiz2gmpWIHVWw0HSQdP
	v4Pk1uQwsh7wQkjJhqvjMMYLJMDae7LmlFwOd0EqGpNnBbTw/D66yHUZCOlVehGtBGTaOfcJ763
	ItyGdKNoUV6dDQSdj5Q3LcH5+NqhvoFXVmG3DdI58n9Hd9ZcrUpe7JVZN3puXrW//g==
X-Received: by 2002:a17:90b:4d05:b0:32e:96b1:fb70 with SMTP id 98e67ed59e1d1-33b51118904mr44538914a91.12.1760586915102;
        Wed, 15 Oct 2025 20:55:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEg1HSgO+nMcnXRtAKiTx8Q7AQAReMvTuE/C3S8VuhwzjFekqA1Fpb56U887OfER7DJGa5MQ==
X-Received: by 2002:a17:90b:4d05:b0:32e:96b1:fb70 with SMTP id 98e67ed59e1d1-33b51118904mr44538861a91.12.1760586914538;
        Wed, 15 Oct 2025 20:55:14 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a2472fe0bsm750566a12.17.2025.10.15.20.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 20:55:14 -0700 (PDT)
Date: Thu, 16 Oct 2025 11:51:23 +0800
From: Coiby Xu <coxu@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: linux-integrity@vger.kernel.org, oe-kbuild-all@lists.linux.dev, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Karel Srot <ksrot@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ima: Fall back to default kernel module signature
 verification
Message-ID: <barlwlddbdnk5ke2a4zbu7ckfzjssfo7lc4w6ffsg2cl6c7rmn@buuhox6wd6zt>
References: <20250928030358.3873311-1-coxu@redhat.com>
 <202510030029.VRKgik99-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202510030029.VRKgik99-lkp@intel.com>

On Fri, Oct 03, 2025 at 01:17:30AM +0800, kernel test robot wrote:
>Hi Coiby,

Hi,

>
>kernel test robot noticed the following build errors:
>
>[auto build test ERROR on cec1e6e5d1ab33403b809f79cd20d6aff124ccfe]
>
>url:    https://github.com/intel-lab-lkp/linux/commits/Coiby-Xu/ima-Fall-back-to-default-kernel-module-signature-verification/20250928-110501
>base:   cec1e6e5d1ab33403b809f79cd20d6aff124ccfe
>patch link:    https://lore.kernel.org/r/20250928030358.3873311-1-coxu%40redhat.com
>patch subject: [PATCH] ima: Fall back to default kernel module signature verification
>config: i386-randconfig-012-20251002 (https://download.01.org/0day-ci/archive/20251003/202510030029.VRKgik99-lkp@intel.com/config)
>compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
>reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251003/202510030029.VRKgik99-lkp@intel.com/reproduce)
>
>If you fix the issue in a separate patch/commit (i.e. not just a new version of
>the same patch/commit), kindly add following tags
>| Reported-by: kernel test robot <lkp@intel.com>
>| Closes: https://lore.kernel.org/oe-kbuild-all/202510030029.VRKgik99-lkp@intel.com/
>
>All errors (new ones prefixed by >>):
>
>   ld: security/integrity/ima/ima_appraise.o: in function `ima_appraise_measurement':
>>> security/integrity/ima/ima_appraise.c:587:(.text+0xbbb): undefined reference to `set_module_sig_enforced'

Thanks for reporting the error! This happens when
set_module_sig_enforced is called without CONFIG_MODULE_SIG not enabled.
I'll address this issue by declaring set_module_sig_enforced only when
CONFIG_MODULE_SIG is enabled.

>
>
>vim +587 security/integrity/ima/ima_appraise.c
>
>   483	
>   484	/*
>   485	 * ima_appraise_measurement - appraise file measurement
>   486	 *
>   487	 * Call evm_verifyxattr() to verify the integrity of 'security.ima'.
>   488	 * Assuming success, compare the xattr hash with the collected measurement.
>   489	 *
>   490	 * Return 0 on success, error code otherwise
>   491	 */
>   492	int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
>   493				     struct file *file, const unsigned char *filename,
>   494				     struct evm_ima_xattr_data *xattr_value,
>   495				     int xattr_len, const struct modsig *modsig)
>   496	{
>   497		static const char op[] = "appraise_data";
>   498		int audit_msgno = AUDIT_INTEGRITY_DATA;
>   499		const char *cause = "unknown";
>   500		struct dentry *dentry = file_dentry(file);
>   501		struct inode *inode = d_backing_inode(dentry);
>   502		enum integrity_status status = INTEGRITY_UNKNOWN;
>   503		int rc = xattr_len;
>   504		bool try_modsig = iint->flags & IMA_MODSIG_ALLOWED && modsig;
>   505		bool enforce_module_sig = iint->flags & IMA_DIGSIG_REQUIRED && func == MODULE_CHECK;
>   506	
>   507		/* If not appraising a modsig or using default module verification, we need an xattr. */
>   508		if (!(inode->i_opflags & IOP_XATTR) && !try_modsig && !enforce_module_sig)
>   509			return INTEGRITY_UNKNOWN;
>   510	
>   511		/*
>   512		 * Unlike any of the other LSM hooks where the kernel enforces file
>   513		 * integrity, enforcing file integrity for the bprm_creds_for_exec()
>   514		 * LSM hook with the AT_EXECVE_CHECK flag is left up to the discretion
>   515		 * of the script interpreter(userspace). Differentiate kernel and
>   516		 * userspace enforced integrity audit messages.
>   517		 */
>   518		if (is_bprm_creds_for_exec(func, file))
>   519			audit_msgno = AUDIT_INTEGRITY_USERSPACE;
>   520	
>   521		/* If reading the xattr failed and there's no modsig or module verification, error out. */
>   522		if (rc <= 0 && !try_modsig && !enforce_module_sig) {
>   523			if (rc && rc != -ENODATA)
>   524				goto out;
>   525	
>   526			if (iint->flags & IMA_DIGSIG_REQUIRED) {
>   527				if (iint->flags & IMA_VERITY_REQUIRED)
>   528					cause = "verity-signature-required";
>   529				else
>   530					cause = "IMA-signature-required";
>   531			} else {
>   532				cause = "missing-hash";
>   533			}
>   534	
>   535			status = INTEGRITY_NOLABEL;
>   536			if (file->f_mode & FMODE_CREATED)
>   537				iint->flags |= IMA_NEW_FILE;
>   538			if ((iint->flags & IMA_NEW_FILE) &&
>   539			    (!(iint->flags & IMA_DIGSIG_REQUIRED) ||
>   540			     (inode->i_size == 0)))
>   541				status = INTEGRITY_PASS;
>   542			goto out;
>   543		}
>   544	
>   545		status = evm_verifyxattr(dentry, XATTR_NAME_IMA, xattr_value,
>   546					 rc < 0 ? 0 : rc);
>   547		switch (status) {
>   548		case INTEGRITY_PASS:
>   549		case INTEGRITY_PASS_IMMUTABLE:
>   550		case INTEGRITY_UNKNOWN:
>   551			break;
>   552		case INTEGRITY_NOXATTRS:	/* No EVM protected xattrs. */
>   553			/* Fine to not have xattrs when using a modsig or default module verification. */
>   554			if (try_modsig || enforce_module_sig)
>   555				break;
>   556			fallthrough;
>   557		case INTEGRITY_NOLABEL:		/* No security.evm xattr. */
>   558			cause = "missing-HMAC";
>   559			goto out;
>   560		case INTEGRITY_FAIL_IMMUTABLE:
>   561			set_bit(IMA_DIGSIG, &iint->atomic_flags);
>   562			cause = "invalid-fail-immutable";
>   563			goto out;
>   564		case INTEGRITY_FAIL:		/* Invalid HMAC/signature. */
>   565			cause = "invalid-HMAC";
>   566			goto out;
>   567		default:
>   568			WARN_ONCE(true, "Unexpected integrity status %d\n", status);
>   569		}
>   570	
>   571		if (xattr_value)
>   572			rc = xattr_verify(func, iint, xattr_value, xattr_len, &status,
>   573					  &cause);
>   574	
>   575		/*
>   576		 * If we have a modsig and either no imasig or the imasig's key isn't
>   577		 * known, then try verifying the modsig.
>   578		 */
>   579		if (try_modsig &&
>   580		    (!xattr_value || xattr_value->type == IMA_XATTR_DIGEST_NG ||
>   581		     rc == -ENOKEY))
>   582			rc = modsig_verify(func, modsig, &status, &cause);
>   583	
>   584		/* Fall back to default kernel module signature verification */
>   585		if (rc && enforce_module_sig) {
>   586			rc = 0;
> > 587			set_module_sig_enforced();
>   588			/* CONFIG_MODULE_SIG may be disabled */
>   589			if (is_module_sig_enforced()) {
>   590				rc = 0;
>   591				status = INTEGRITY_PASS;
>   592				pr_debug("Fall back to default kernel module verification for %s\n", filename);
>   593			}
>   594		}
>   595	
>   596	out:
>   597		/*
>   598		 * File signatures on some filesystems can not be properly verified.
>   599		 * When such filesystems are mounted by an untrusted mounter or on a
>   600		 * system not willing to accept such a risk, fail the file signature
>   601		 * verification.
>   602		 */
>   603		if ((inode->i_sb->s_iflags & SB_I_IMA_UNVERIFIABLE_SIGNATURE) &&
>   604		    ((inode->i_sb->s_iflags & SB_I_UNTRUSTED_MOUNTER) ||
>   605		     (iint->flags & IMA_FAIL_UNVERIFIABLE_SIGS))) {
>   606			status = INTEGRITY_FAIL;
>   607			cause = "unverifiable-signature";
>   608			integrity_audit_msg(audit_msgno, inode, filename,
>   609					    op, cause, rc, 0);
>   610		} else if (status != INTEGRITY_PASS) {
>   611			/* Fix mode, but don't replace file signatures. */
>   612			if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig &&
>   613			    (!xattr_value ||
>   614			     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
>   615				if (!ima_fix_xattr(dentry, iint))
>   616					status = INTEGRITY_PASS;
>   617			}
>   618	
>   619			/*
>   620			 * Permit new files with file/EVM portable signatures, but
>   621			 * without data.
>   622			 */
>   623			if (inode->i_size == 0 && iint->flags & IMA_NEW_FILE &&
>   624			    test_bit(IMA_DIGSIG, &iint->atomic_flags)) {
>   625				status = INTEGRITY_PASS;
>   626			}
>   627	
>   628			integrity_audit_msg(audit_msgno, inode, filename,
>   629					    op, cause, rc, 0);
>   630		} else {
>   631			ima_cache_flags(iint, func);
>   632		}
>   633	
>   634		ima_set_cache_status(iint, func, status);
>   635		return status;
>   636	}
>   637	
>
>-- 
>0-DAY CI Kernel Test Service
>https://github.com/intel/lkp-tests/wiki
>

-- 
Best regards,
Coiby


