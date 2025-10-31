Return-Path: <linux-kernel+bounces-880482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB39C25DCA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E44E1A26714
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EFA2DF132;
	Fri, 31 Oct 2025 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xaIzXA4x"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9CE2D543E
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 15:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761924954; cv=none; b=k/to5z0Qdr8c0RU2SSxmYbQPkxJDVBznSJFB/jIEj9qGFljAKZJR9b14HqEyLCuQEKuSTPySpOJliTbfUpdjsFzmIPWRHdF5rwCkzuE5FRcQ82L2Cm17tY8WmqSQruZb3nChHibz7V9Fc/uym2lJLki30svbqdOpb3QMbsWR0uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761924954; c=relaxed/simple;
	bh=qiLdJIzVO+jKGGBbXYftuUXlskKJmBc2AUMgGXCy3fA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIVzSAa6eO0imCA1eFtcS3Kk50nWdC1zfhUy10QEBgbaUXNqqAwTDjld0gfBK+IAd8HCECaL1AMhGfgCTC7zQvxBQFx1ZdPB9mNEncrGckh48KL5p3WnO/Umt46mSC36/QSjaa+C+YhL7sAK0JqbufXhofS9BBV6iLIcY89+S3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com; spf=pass smtp.mailfrom=compal.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xaIzXA4x; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.corp-partner.google.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-87dfd3c24ddso34691326d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761924950; x=1762529750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6ACvehQQuyEQdMS3T6Vr1FtAWe8uc2yBWuRjxIoUTA=;
        b=xaIzXA4xsy/o5bo+GzQMg4ii6bwwtustnednq+QcE3D49Rh3bRhWQdNpSbyBl49eO9
         wd+zhgcibTh1kf6R8XZHOMoTOvSoBoS1ny7jRgFiymK9b8I30I+mYbWcXQXZ7v9cJ2mH
         Pmy74C3BABHuzlrVCenUUyqSPcoxHlW5lvTOsZEXgeYhH/3Qn5zT1ja6ErRQtQRq6C/1
         Ny1e5xZLTXYS/iJOzLepkrFKhhKJ3E8uq2wB0YXVhS1IBdzjZo9IckxMrmV0cfyKkuUk
         zk/1qeItlZCxVDSdHIO8mJjlM42vPN8ezfLgncY7iWidgy33GylMjRR5YNog4Z29qCck
         J9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761924950; x=1762529750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6ACvehQQuyEQdMS3T6Vr1FtAWe8uc2yBWuRjxIoUTA=;
        b=xASokjXh3XtxdYzlNbzW+4ARR3QOoriWgS0ThXJu7nEYJlC7IzG7Jwr6FB3DCiX7qt
         4ZYqfn1qiUY0cTpIzym3OXM9F3LHUJWRmgoT9ueKGDBeH7mKogIFWehiUHKCAfVSLJSm
         Tz/4NEMbSU3mepxZFqqeXUhrJMCEtWxehqrAb+oqSjV2RyyXMXqh4b4kwZSmnZfGW4An
         BXNFywMB9JH9l/ZLDsrtZYRo/MTBZs5sUqTp0XjpIyRMdTbg1rJlI/qb+b/cz9OQ+3m7
         Bpc084E1K0dwwNJqDKegZztGoY4/6ajrVj5vjXzsJaC5wV9RjipHJEXVn5Wj63YwWHBA
         cUTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvEaDJrt+JdTP1MqFj8j/eilu0kA6KnyGZSvVoVr6ds12Yl+noslqfaaFl5NEInW7X3X75nXrHzN6lI+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz21f/utjBm3uHptTLTbdxUYadqf4q0PTEaGbhIpCzD1a3O2+oj
	QhzMa70unxcQCOpjvDGnUAWgxR5+r/eW9o5NEDnrB9u//Utkc+VIyUOSQK8Afzl+SKtran8pwi9
	CisnaPyCw4xRLNgLQc7M3ujMRKXtiQszx3fDCRaddWw==
X-Gm-Gg: ASbGncvmIm5ky0PfZ4+kKnPvu517GALulP/oVQXHr4GNd2bWYWCs595MeCQddhRVCgA
	pKLjTpqfYeTf5DdL3EFV+TIkMUNF/0KBixnQcxDcHbHUzOFw7m4buX8u80NI4tJf2yza4XrbXkv
	3ZtBVP+0FdoT/CtogzEdEpa5KR6iYRRWP8lG6DhSfSddx5Pejc59HMZ1LYua6lCoh82PbxjnWRU
	qLPznxl9Gnl3C4qBcHFox74LY1+B8QARGOvKteauO7ucGq7ykac6EJeR2OpSyTGNdqVMre2VKhP
	136208cvBzPJk590/w==
X-Google-Smtp-Source: AGHT+IFa/2cbIGKCDZ2v8wEyvKnZrrGJFeRexJg6fwcZTSltyNTrXO5QbxDoX827DZL9AHbtcev7dhQ9QG3pQWiW/UQ=
X-Received: by 2002:a05:6214:1bcd:b0:87d:f969:6a7d with SMTP id
 6a1803df08f44-8802f2d2d04mr54375076d6.18.1761924950343; Fri, 31 Oct 2025
 08:35:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030094434.1390143-1-ajye_huang@compal.corp-partner.google.com>
 <CAD=FV=V6xV0m4pj=7f2dxDP-0A1AaQuYJP5NAnXNz1_bzH7nSw@mail.gmail.com>
 <7071a2b8198c09011c84d39b45dc6d1da4b69d12@intel.com> <789d88744fbd3a05758971dc8d893fb4599475f3@intel.com>
In-Reply-To: <789d88744fbd3a05758971dc8d893fb4599475f3@intel.com>
From: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date: Fri, 31 Oct 2025 23:35:48 +0800
X-Gm-Features: AWmQ_blxyQaGsb2G54AT5MgQtyEAT64D04t6hwU5kGIchciQ4ACQDUgJ67aHa7I
Message-ID: <CALprXBb7w_15kOBo=ZUzD9vhKyPDD34frk9UYmcQvS_7vEfNaQ@mail.gmail.com>
Subject: Re: [PATCH v1] drm/edid: add 6 bpc quirk to the Sharp LQ116M1JW10
To: Jani Nikula <jani.nikula@intel.com>
Cc: Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jani, Doug

On Fri, Oct 31, 2025 at 6:40=E2=80=AFPM Jani Nikula <jani.nikula@intel.com>=
 wrote:
>
> And as soon as I hit send, I notice the quirk is missing BIT(). It's a
> bit mask, and the enum signifies the bit number.
>

This is my mistake, really sorry about that.
The  device which is equipped with the sharp panel uses kernel 6.6, which
 #define EDID_QUIRK_FORCE_6BPC            (1 << 10)  in drm_edid.c
However, the kernel latest is using enum, really appreciate you all
find this my mistake.
 I will send the v2 ,Thank you all.

