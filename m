Return-Path: <linux-kernel+bounces-865702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D906BFDC8C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FCD94F63B6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836BF2ECD05;
	Wed, 22 Oct 2025 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0Sy0WMG"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C8D2E9ED1
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 18:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761156761; cv=none; b=SNRBtKJIaPtpZyhWaZpWeTGFcbRg/JI6FucMZG7Rx4p28FUcVZw7IRGaPtfP0J89ESQBrwlI4q1EaG6nmy3JGO33Tkza6jgg7dG/1T6XzVHiIzGkRfNVpJMRFoaTiofhMqyOCsFOwUlwQ6mM8TzgO/IY4+n4Nc/SBFj5RteNSmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761156761; c=relaxed/simple;
	bh=L3H3gsvk+jEZsW0PrATObZIO7dMoEWR3ceyCKKKxT6o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rT24npPkeRc/TAOmYco6BCJJz2bcAm4QQHHXyuIPUmxhjyN3kctmsVyYalYPDGwa/E4lOCWYTr9yYm671iYdCLvTGNonbu+quGOHv4e/iC/esE4fOQXTKuC36F4uuqpoU/pQLjK0ldpQQCkXbQAbswvuycprXeWmMcfXZm46CmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0Sy0WMG; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-796f9a8a088so6522498b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761156760; x=1761761560; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3H3gsvk+jEZsW0PrATObZIO7dMoEWR3ceyCKKKxT6o=;
        b=G0Sy0WMGaVhEyLNLbZrQbxDy1xD4EKYWgQu3CrW2I87O3DqmKrvJFReLJe47r7GsVA
         SJhtkmx92BYSi+Ft46QxG1u2IYkd0u6G6yBA3nHX95fJD2+vy7WAjxfw6oPUaJUhIcGC
         l7EUmc3deb1qapLgdkCzheRoDBdQBFR1ClyFDHBkVBd7wW5gxDnWCM/IqJ250YfoHX9k
         DfGz5bvw34FP2x2//qkrYpiId4PTfGmm02UDT+rqiwd89jEUXYldHkjeEIHcQ6TZVmHk
         KHGT/5AApvR6sParWYnOLtvgBv6kGai1Jg1i/zNI3q6DIOAXfmsjsklO1ooX8E5PdRsG
         zEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761156760; x=1761761560;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L3H3gsvk+jEZsW0PrATObZIO7dMoEWR3ceyCKKKxT6o=;
        b=gjgPvo6NnVpz3B4EEAfRTCE5ddtWvIRfXqr6/z/xkcVBfYgyqK2DxGfA1zgdMTc9wF
         OjevK9imsnQ3z6b2Osi6B7yZYqMEjQiubQ/lO+zAGcmXo6OWlG0FlT3I+DKkjFtFbVO2
         CpLz7O2lL2BMD5HPE+dSp+rxmv4Rqo/TyMgWvNcnMXLgDAsyEyLgPWnTpId2IrBa3IM0
         jxcqVg5VzZ8DdYMkZiE+nVI/hY0XsyvtZCetLoS9rk+yex522WW6IIVBzHeVht/y5daj
         O+OKGmle9WoYeYHFJbr65WtqDjBRI9hnMOKcoNJMSY2LoAqRsOtKuc2LeMoUp6yVexxU
         bBpA==
X-Forwarded-Encrypted: i=1; AJvYcCUFG1tibkzXV8afyLxfJLp3I6LyhcEYE8q5fyvCHanlLV4TQi1ncbcP+d0mZ18MvCg8PsoiV0FpybWrhY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YynrMUxzX/Xw2RaTnud7vDrAeBQ9SLgESbtHLSA/ZYpy9CTkELA
	Pfn5HNcgAkyUwbDYE9pYVyaGza1/es+19UWGn8itP8/K1yPFnEA9WbxG17fAojr1vpuS+g==
X-Gm-Gg: ASbGncuWGtlWmiLSnooe+bPFBkD3tDKVmXDQV3wIfNNfkHKAwER1TW6xY1t+imA8CLH
	echFba7I7yJDCNn5pj0nur20PFMVQx1Dm7zRfa7lRnK572pfKDULYOw0Nk7jjBS9YrT3s6MpSje
	JKOOlvbP91+fhu1cAfMAQHhVT8ue44h5tw8kaSZKYRPzRLSISHry5kNxrLjygSfBqLPHdtMrod/
	svugzFLaVFgm6eai4RcrRHVPGJsDkI7nvleeDE8su0fpbs7L71WjQbkI5G5aWVO9eF+5EbxzUv/
	KD/iRFPfIjJxBJFD2ca0U/ApipH0EdaMGKmgAY5qpbumanbiLJ00jp8AzAc8RwlBrWqPZz+YMLn
	kqk9pX8JktMmyCSorIYbXU2qcGEyzxriM6v50VHcp36vguHZqJByyADsSHp7g2Kq/+Xx/qfPtRN
	FvRJaJ
X-Google-Smtp-Source: AGHT+IE9ukly3OsSJtf/F5Pi5q/3u1rh2/j7Gpz3fL8FIoDXhYOFoguBVAVtJ0gXkaH9zj9KjLEqdQ==
X-Received: by 2002:a05:6a21:328a:b0:248:86a1:a253 with SMTP id adf61e73a8af0-334a8564096mr29786646637.15.1761156759601;
        Wed, 22 Oct 2025 11:12:39 -0700 (PDT)
Received: from localhost ([2405:201:3017:184:2d1c:8c4c:2945:3f7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff158bdsm15487022b3a.16.2025.10.22.11.12.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 11:12:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 23:42:32 +0530
Message-Id: <DDP1YQXWXDVQ.FGRPSKHQ26HZ@gmail.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>, "Christian Brauner"
 <brauner@kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Aleksa Sarai" <cyphar@cyphar.com>, "Pavel
 Tikhomirov" <ptikhomirov@virtuozzo.com>, "Jan Kara" <jack@suse.cz>, "John
 Garry" <john.g.garry@oracle.com>, "Arnaldo Carvalho de Melo"
 <acme@redhat.com>, "Darrick J . Wong" <djwong@kernel.org>, "Namhyung Kim"
 <namhyung@kernel.org>, "Ingo Molnar" <mingo@kernel.org>, "Andrei Vagin"
 <avagin@gmail.com>, "Alexander Mikhalitsyn" <alexander@mihalicyn.com>
Subject: Re: [PATCH v2 1/1] statmount: accept fd as a parameter
From: "Bhavik Sachdev" <b.sachdev1904@gmail.com>
To: "Miklos Szeredi" <miklos@szeredi.hu>
X-Mailer: aerc 0.20.1
References: <20251011124753.1820802-1-b.sachdev1904@gmail.com>
 <20251011124753.1820802-2-b.sachdev1904@gmail.com>
 <CAJfpegtW_qR2+5hKPoaQnPRPixFUnL3t8XpcByKxLRJvkroP5w@mail.gmail.com>
In-Reply-To: <CAJfpegtW_qR2+5hKPoaQnPRPixFUnL3t8XpcByKxLRJvkroP5w@mail.gmail.com>

On Wed Oct 22, 2025 at 10:02 PM IST, Miklos Szeredi wrote:
> What's wrong with statx + statmount?

We would like to get mountinfo for "unmounted" mounts i.e we have an fd
on a mount that has been unmounted with MNT_DETACH. statmount() does not
work on such mounts (with the mnt_id_unique from statx), since they have
no mount namespace. These mounts also don't show up in proc.

v1 of this patch tried a different approach by introducing a new mount
namespace for "unmounted" mounts, which had a bunch of complications
[1]. The cover letter for this patch also has more information [2].

We want to support checkpoint/restore of such fds with CRIU [3].

[1]: https://lore.kernel.org/all/20251006-erlesen-anlagen-9af59899a969@brau=
ner/
[2]: https://lore.kernel.org/all/20251011124753.1820802-1-b.sachdev1904@gma=
il.com/
[3]: https://github.com/checkpoint-restore/criu/pull/2754

Kind regards,
Bhavik

