Return-Path: <linux-kernel+bounces-749527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5ABB14F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FBCE545462
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591081E7C27;
	Tue, 29 Jul 2025 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiHUMa30"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABDF13D8B1;
	Tue, 29 Jul 2025 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753800318; cv=none; b=k2tUKzZL2Lpwu5aRSh4O0dLlo7rHQtwCITHauO5JdtpqHZ1d0F4qCzmrdJ1Af+RAHtHta3r/hbjt0JDYOdv7toqUfB2T+e29qQR1fONDHQP62NRlpsNFWShU0hhXj6DBJHXYMYL215aJLxfrsEaY1cYiQ3bvuD5vwB8iSO+lRlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753800318; c=relaxed/simple;
	bh=SqKSXMyKE1pb1btB4u4HtX000tSuP3Xq7jg/MY0Ben8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EB17ffj/tW8k14492sNY+iM/ICt+/MtP9uIYImWPH5E8csvR6oiD9WHAeoAjdQlT420uvZK68gRUze7QaL268tddVWn1K5K8EivvQoVRSo7dXjbBJrozEXmNwdR5C95dCJOw+O/lOs9+JyejXEKPrVbDERUcla2GC/HxMTjxj00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiHUMa30; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-615e56591aeso3127863eaf.2;
        Tue, 29 Jul 2025 07:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753800315; x=1754405115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqKSXMyKE1pb1btB4u4HtX000tSuP3Xq7jg/MY0Ben8=;
        b=CiHUMa30kn5VD03XP8lWtZunaptFr5GBrW41iJ1f++JFM4rG9/A09HSwo3ILaJt7V4
         Q2hmCiUCFyrZCh8grAdlwh/mMSY5dyoB64vFfaId50H3ZiC38dFcMoTgRmr06ghrL3qv
         eK6dS9GHBm+czCSum+2kSMbwr6hqlyiQ2GQQcv1DrDRQuys4iZ2Z/yp1arSzRxAGxnoo
         OAAzthQBIht5qXKYvLvV9t1z6HjGVJBqKnjbC5qqX9oc0dSV7LsEbBK4w348z224gGqp
         WFj8xCygNKaY40TbjI23T3LNdYkKq64U3uLj+vglRYvo24wPcto6cJkE+w9kPRs74mo5
         JhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753800315; x=1754405115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqKSXMyKE1pb1btB4u4HtX000tSuP3Xq7jg/MY0Ben8=;
        b=tuT0lWFF0aOU7l72a2bfMABDDvF6TBpSBWETPKKFj64zPlQGCPyemtpuCmfGWHttW+
         vosWtct4pA/JPrarcgpFYOKnIP823Ytc37LYjh7fqixRDaoOxvidqzaXsbFzkhP+WVD4
         5UulR7s3BF4zYcAUr5vHrs/RWkqkKcD6Q2RemI8901dPzSxnfVShz4pSN568SU1NX/Bq
         WYA7aCGuZ+VwVm1fALsmKf6MtZovsmFkySg1DPFtHR/W3ScCQvn1xL7zo08dBGZKAq/L
         8ZkYVYrtU7Vpwn5jmbGVBtco8RuoGjwN2dTxH8YEjAUDH2GYW1XVCIUDIicQvTBD7OPr
         itqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUERVr6Er6GNu41Z1fg5ZrAMoD08uYKzkj7idNeYoTIoJK14Bs6bZRAMjoh14kfQ295ZDLpON2AYWhRslea79w=@vger.kernel.org, AJvYcCXGW+g0+bHTXWuzwCdUXkPwR0QTQe8CXImYyVp+Gx5CvmuDgzJO/kyoIBUah1FPP7lCK0B+xlU3sjS9If5Y@vger.kernel.org
X-Gm-Message-State: AOJu0YyipYDJ0K8bqeegxTwTdCweBpvqCUGpZEzRptrMhzY1n7PN4FBW
	GkZaS/lfq2AqN6HU1OGpbyaLvph5KhjJJhlq266VWei4q6j0lGPZh7nP6sV7isFmkSdmrAWx2l/
	0f6Uc40PWwOEhC42ebke6LXZJMYFU44M=
X-Gm-Gg: ASbGncsWrIIpWOjZAKYGLm0jY/2Ww6FHe8ALNKnhSrNlE3oy4AKXJ8BITAd9YOYi7H4
	3J4+HJ4dHKmXBt56WQFdUS+S5MuHz9MEYzy0svU9bvKDhxX23VwqNBK+E4ngsdZJwMwvUsChYcs
	6Q3dMHaRpvDemcw65Lqz9oJOv8mIFKOXy8JapHyxuPvKC4x+YrzXmSyCu5KgGOkfumO/pFiQ1LT
	KU4bSHZ
X-Google-Smtp-Source: AGHT+IFHmgLm4QtA1gMM68QZkXVDwXCrzQje62zufxoahmmzdI/oX1Oj1iWO1COkXuVtE5Extl2/Y5qlaKrXIMvaQ4M=
X-Received: by 2002:a4a:e906:0:b0:611:ffa0:3863 with SMTP id
 006d021491bc7-6195d29252cmr38156eaf.3.1753800315371; Tue, 29 Jul 2025
 07:45:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250727125044.101779-1-suchitkarunakaran@gmail.com> <079be718-ae8f-408d-a789-05f4816e0bd4@web.de>
In-Reply-To: <079be718-ae8f-408d-a789-05f4816e0bd4@web.de>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Tue, 29 Jul 2025 20:15:03 +0530
X-Gm-Features: Ac12FXxxh7hpT3FnQiBPNFL1EGOADL2JW_Lh4kOSk8OhVExH7PpSacHx4mz2er0
Message-ID: <CAO9wTFiQdHA3JjXAbmXdxmeUHehVY+43+zg4BiYBxY7coSi+Ng@mail.gmail.com>
Subject: Re: [PATCH v2] checkpatch: suppress strscpy warnings for userspace tools
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-kernel-mentees@lists.linux.dev, Andy Whitcroft <apw@canonical.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Joe Perches <joe@perches.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Jul 2025 at 20:12, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> =E2=80=A6
> > This patch suppresses =E2=80=A6
>
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.16#n94
>

Thanks for the suggestion. Will keep this in mind next time.

