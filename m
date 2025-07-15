Return-Path: <linux-kernel+bounces-732451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49578B066B5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 21:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8347C5658D7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 19:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B854D2BDC26;
	Tue, 15 Jul 2025 19:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="Xs06nDen"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0776626CE1C
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 19:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752607222; cv=none; b=TkRWyMPFXsMDcz2eWlQCDHx6OMH1+FUvgdacEm7d5Hav5TdQMF4O59gc0SXL+oFYh4JX9Er2fghwqaEGbZRje0WeGcCRu93k+AeMMPQN3KumM/je0iEo3B+qPojO7Ovo+kVJuK8bBsH+72FKZ0AUdOssKYulRkWQ9my0ajORdPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752607222; c=relaxed/simple;
	bh=z9FEBK4ATYBXZXrK4juNd0w6CLSefdZH8NpY8gHimyk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QwV0Gz1UTS7T9BySN+uWdKDWZ4KyFGCYa7IRMBUiEYPlDclqHSV8bpmKEFPqhtvlWpsswjJgRGmgOuaMXya66OR6ZvHmByO2e/j3fPqv8TyyWUpWzm2a0YG7XxaFb7YDACbp+jYsLrTCkaWe0u5VZCGyvVkuC4GICdfvlavO99M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=Xs06nDen; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e8bbaedb460so788465276.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 12:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1752607220; x=1753212020; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0Iy19JY5XNgs3r8E4txe9TVMwR2RCJAFm46qs90Z6yE=;
        b=Xs06nDenG9YcZAOomQbR9gf2u5uvxJmEbUHsTys9ddjSDC9zGHETcLnQq5Bk8yONcj
         D6zj9eiAyMZ6PbYxJxL5bfoRplaSLwIDoMZWxawqLsuWXZM1OqoiQ/dzms8860C6IMUl
         Hv+6OICVa90ZrhjS2OamUr5zXtG/Nrq4H28fZeRTlT2lYYIaxuWmfz5MVSbS34chboBl
         23SifGGirTjOEWuWp+CBCctl9eSO4eVVue6eSKF+dBIuV8xGjcoqeRbKTW8Kh+qbZfQI
         Y5H4sL/4dqcSlLTuYmQHQhLK8xRrHIGobZ85WnNHMCQPAFIBls6Sm0oGKmnp2cx+R1jU
         G8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752607220; x=1753212020;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Iy19JY5XNgs3r8E4txe9TVMwR2RCJAFm46qs90Z6yE=;
        b=YzJnFqoEFfoGTB4pcWyJUTXmOCPcCOBR7+JAtWqx0Q1PJVjQSqa3mlxAEVK4O2OLla
         SAjdoQTJ7wHyRQ2553PMOijcewdZgIfq7/z8XjnrzoebxAXm6Ng1ttnz77zQLLriQJIF
         VOKfALbifup2vcN9uEqHPKigRNjUhjS+BIKEGbNVZkRAlwZc/j6OUJcKAstPKCpgeuzi
         IBhMs8CkJoa3UEAFZTYM3FxLaB7uqtLzC4RtYwHDpgOASHQr2cwL4tTwz4IbaXUvG5/8
         x5ienJ9SO8rbhyZy1iEEdSYZM6luubuNuC6s/ex9eeCnKyTMpgRvo4yHDh8Jud79Zqnp
         bT+g==
X-Forwarded-Encrypted: i=1; AJvYcCU1MwJ1u8flPCRKKTV8fmFPZU7pMNawc70GCD6lBNSb/7Q5jG//KzxpMDMIc49ays7sI+RWq9iFHmYgY5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YynsGeautK2CpthS3zbC2G7Q1zjXrHFUntOME3Cm9jPV1iM922W
	tEHNULeZFaa3BGKQRRiXW3R+Y+tCAVF/o6522CxSyi/5TSsUSY4SfISSg6hk0aLZi90=
X-Gm-Gg: ASbGnctuoGfBFdpavrtel1+9hh/8jdFV1vDmMpH1tkxb/bHKtzmThX7mbobuZUoGCT/
	dApiU+CT78fPQz1bC0xwm+VhPhGKFh7J/mC2Hyzk5Y9q7mU0HnPUCzyA8UsMayEQOzESzJVHyJp
	AMWeemyTObF7HZSshZ1MUGEzAV/jVkv2JpwjzZHvDLwBgD8PcHyipcP9uJeNZbQ3oXCxyhwTh08
	pEIRKv7NvqfMqEmx8+KXqc8I3gHK2dsgIX6WpHL5LaQmGyTL1yQjbCLyVjbe87woj6Z7g5qinPP
	tUoNyCl/f7+XtDGiSWYR90QN9f/uyokrmku1F8vOjBnTwycBJy/gbACa5yXQ6NN/NbViDOBSoON
	oe/b4ifVaIg2tAfPOnIfRRYm3gLRwtSuWVXCYlWKUvtoGjg1eh7XQVcZjYRS/2TlB82+BqA==
X-Google-Smtp-Source: AGHT+IHDrtoSIdUfR861XkjZK3RuIKJCU3EePRJBEIqf0iO6i4dldB0AavSvAIg/dfE7IIXbJu85Eg==
X-Received: by 2002:a05:6902:1381:b0:e89:a15d:2bf6 with SMTP id 3f1490d57ef6-e8bc269ef23mr1980276.7.1752607219589;
        Tue, 15 Jul 2025 12:20:19 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:b4ff:5ce4:f713:9976? ([2600:1700:6476:1430:b4ff:5ce4:f713:9976])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8bc19023e3sm68413276.7.2025.07.15.12.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 12:20:18 -0700 (PDT)
Message-ID: <4c1eb34018cabe33f81b1aa13d5eb0adc44661e7.camel@dubeyko.com>
Subject: Re: [PATCH v2] hfs: remove BUG() from
 hfs_release_folio()/hfs_test_inode()/hfs_write_inode()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, John Paul Adrian
 Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel
	 <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
 Matthew Wilcox <willy@infradead.org>
Date: Tue, 15 Jul 2025 12:20:17 -0700
In-Reply-To: <db6a106e-e048-49a8-8945-b10b3bf46c47@I-love.SAKURA.ne.jp>
References: <ddee2787-dcd9-489d-928b-55a4a95eed6c@I-love.SAKURA.ne.jp>
	 <b6e39a3e-f7ce-4f7e-aa77-f6b146bd7c92@I-love.SAKURA.ne.jp>
	 <Z1GxzKmR-oA3Fmmv@casper.infradead.org>
	 <b992789a-84f5-4f57-88f6-76efedd7d00e@I-love.SAKURA.ne.jp>
	 <24e72990-2c48-4084-b229-21161cc27851@I-love.SAKURA.ne.jp>
	 <db6a106e-e048-49a8-8945-b10b3bf46c47@I-love.SAKURA.ne.jp>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-15 at 15:51 +0900, Tetsuo Handa wrote:
> Since syzkaller can mount crafted filesystem images with inode->ino
> =3D=3D 0
> (which is not listed as "Some special File ID numbers" in
> fs/hfs/hfs.h ),
> replace BUG() with pr_warn().
>=20
> Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D97e301b4b82ae803d21b
> Tested-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> =C2=A0fs/hfs/inode.c | 6 +++---
> =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> index a81ce7a740b9..794d710c3ae0 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -81,7 +81,7 @@ static bool hfs_release_folio(struct folio *folio,
> gfp_t mask)
> =C2=A0		tree =3D HFS_SB(sb)->cat_tree;
> =C2=A0		break;
> =C2=A0	default:
> -		BUG();
> +		pr_warn("unexpected inode %lu at %s()\n", inode-
> >i_ino, __func__);

I don't think that it makes sense to add the function name here. I
understand that you would like to be informative here. But, usually,
HFS code doesn't show the the function name in error messages.

By the way, why are you using pr_warn() but not pr_err()? Any
particular reason to use namely pr_warn()?

We had BUG() here before and, potentially, we could use pr_warn() +
dump_stack() to be really informative here.

> =C2=A0		return false;
> =C2=A0	}
> =C2=A0
> @@ -305,7 +305,7 @@ static int hfs_test_inode(struct inode *inode,
> void *data)
> =C2=A0	case HFS_CDR_FIL:
> =C2=A0		return inode->i_ino =3D=3D be32_to_cpu(rec->file.FlNum);
> =C2=A0	default:
> -		BUG();
> +		pr_warn("unexpected type %u at %s()\n", rec->type,
> __func__);

Ditto.

> =C2=A0		return 1;
> =C2=A0	}
> =C2=A0}
> @@ -441,7 +441,7 @@ int hfs_write_inode(struct inode *inode, struct
> writeback_control *wbc)
> =C2=A0			hfs_btree_write(HFS_SB(inode->i_sb)-
> >cat_tree);
> =C2=A0			return 0;
> =C2=A0		default:
> -			BUG();
> +			pr_warn("unexpected inode %lu at %s()\n",
> inode->i_ino, __func__);

Ditto.

Thanks,
Slava.

> =C2=A0			return -EIO;
> =C2=A0		}
> =C2=A0	}

