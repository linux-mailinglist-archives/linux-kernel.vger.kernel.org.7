Return-Path: <linux-kernel+bounces-808622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9103BB50266
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DDF54E577A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F011B350824;
	Tue,  9 Sep 2025 16:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRCXwqrn"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8463218D8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 16:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757434892; cv=none; b=OEX1QeWFYWDPDeZgtr2Nflv1yQmZYnMf81mna3iyycVVMrVJROd2O/IpbKt9xO6txH1MZlpsO6OdOGcVhr8hduB1zmuQUfzhIkUvyEEkcjGmW8my4cuYoOSzm0uPnEdZuxZADK1RvwO96uKKvXjnp0VJ7xa5oMQ6CpxThZBE8yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757434892; c=relaxed/simple;
	bh=yxjGEwMnmzYxVe6dPgtLt2f3hE2Y5sP/lvr+k+Xo5OU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xx0jIzjvk1qs3H9GXQGjtxsnTlGzITs5NrtSGIAGZc4Bn3pGBqFuAsBr0pKlBqWj5sJKuyez1lpU/VxrX8xsNPyxBHV0CQTxLGudX+ruS18BzS7H3HgdFEDrdG+aoi+e8/vZzLyXiSChXZ0pM8/S9wrM75rbl1zl+B02GUfjBKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRCXwqrn; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24b150fb800so14578145ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 09:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757434890; x=1758039690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twavimEyCpt+hWxU7SUvHffE5IVjpLZ+szv1ZgV6xvU=;
        b=iRCXwqrn45zcek74uypfvNSo8rx1SErwFGSOofH43KP2JjTN3kcXXiGa8HUsIsGp8L
         FQspr16gI8oa/9tXWJ8Eu1NtMWgwrIIh7NWKYdIJWX7JhHSYMe8LTp8xltriLu5dTnCZ
         iDbceSsgfQRKPiIDDojt9QzIZu3qHTPOnwjSW06DSyvrL7ET6bOpefevVcXorFT7AFjL
         ArUfy86bcW8uvkJR/3cbEh6pkNywLCtcerUpdPbVv4o2DDrWmU6aZvLUyodlBZGuv4sa
         ST+zW7FlfjaOP8fShLFIijJv7E9H8n2ZybXELUKJxC1IFmdWov+Zh/rYrlUMmH1B/Sbw
         FqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757434890; x=1758039690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twavimEyCpt+hWxU7SUvHffE5IVjpLZ+szv1ZgV6xvU=;
        b=VZsUAuejVc/7N/RC9dog7kjbRi9oziZ/bVWEET7wWYP67DtEeA0RG2lnHKhLgXAUgb
         9gefQLtOSlvtgELSSlaijJ7pmUxtqWiNNpjpOPVRcNGqV+UMTfjmdr4wdEk3TTYWdMjp
         ihSijfbTplO+mPHnHw5+YFfFYe5s+Bw/aMW050BsmPdZSxLTxOOr0q5EaMbEq9+FAKb4
         IpReaTnfx3V2Vg8RPh3SiuEgB/jazGmvym/2pIQ6iQ4DG2eniznxv5lNwOWSXY4yNPHR
         yJA/oaQAcWkyWs+CcY3oZREJs8SvhVvXRhVuhI9NdM6xNv+/PeVWq95UID+YMhyqM2Gx
         UcHw==
X-Forwarded-Encrypted: i=1; AJvYcCWyOk3gfIJDXzl2T85LxrWYXgOXigEoMFjhUtsCS/3slCihMShFTB55sOaAdtoswy9Mfpq2qpViCkumOUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE83tJRdIIT3bftql85NOxhCcNaFek/dIWHbuK6rI+4Gi+5u4D
	IQr2+zej7+kZcwEvi6mXM3gNdMjhjyB2zY/motGbCQdCr0FqXvWvv+FNwntdDA5opD7EdKitwYu
	bSxX8lHqkpP97R7NIPzLE4QCK6g/Mpprdog==
X-Gm-Gg: ASbGncs/FicxMpQeTNtpX21TfyqYMbnI2hRQYHEQonK/Pcy7FWCWNbEJ0EulTTschHF
	tFR9+W2rj/2R2gjcdYczl66TSqLgmyua5ro7PLQUqyV8D+Q+OF/EJq6JAnr8qf4N07y3KzX4YlN
	0cWYVs2FL2XzjG8Pqh6D1nDpKRLG3NFP3bJRAnwbD59ZfnhknGCN3BUpX9Md/soanAT8i0wyDI7
	Auv+u0eJawEcbdQMw==
X-Google-Smtp-Source: AGHT+IGFmpLRHs90cmwzuNefLvj/CbyZPVvhGfVJue4Ur8IBfka1symWQMSEOXPEBIHDXCQjV6t6JT3Qe6Q8Gn8JksM=
X-Received: by 2002:a17:903:1207:b0:24d:8d39:d2fb with SMTP id
 d9443c01a7336-2516fdc7599mr92780305ad.3.1757434890411; Tue, 09 Sep 2025
 09:21:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADnq5_Oqonrth+5T-83dnFBZ67GvykkPt-9aUepJd+fUMwnupw@mail.gmail.com>
 <20250829194044.GCaLICPKJcGJRYdSfO@fat_crate.local> <20250829204840.GEaLISKGTwuScnDF8Y@fat_crate.local>
 <CADnq5_MbpYmC2PSyOr0gQk7F8mVz0-LG3dZtUZS2HhV8LTgDww@mail.gmail.com>
 <20250830174810.GAaLM5WkiFc2BtQ6kW@fat_crate.local> <51ae551b-6708-4fcd-84f9-fc1400f02427@mailbox.org>
 <20250901101011.GAaLVxA_Ax0R-Wy2IX@fat_crate.local> <2764782f-d411-4142-aa56-f1af0968ecd5@mailbox.org>
 <20250908180022.GHaL8Zto-PsVsPa0e0@fat_crate.local> <63b7c020-e589-4644-887e-3922af939009@mailbox.org>
 <20250909161648.GAaMBS8ERsvv3NbJoF@fat_crate.local>
In-Reply-To: <20250909161648.GAaMBS8ERsvv3NbJoF@fat_crate.local>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Sep 2025 12:21:18 -0400
X-Gm-Features: Ac12FXxIrust0s1Y148Coo4wEhKxgxrPfPL0IOB8UqI-yS2cDR-dlyuYhKne0xU
Message-ID: <CADnq5_MOazXJ4tUNa5uMdkWY7ZCu70M49yG00JsNHB-FO7XNvA@mail.gmail.com>
Subject: Re: evergreen_packet3_check:... radeon 0000:1d:00.0: vbo resource
 seems too big for the bo
To: Borislav Petkov <bp@alien8.de>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, 
	amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 12:17=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Tue, Sep 09, 2025 at 10:43:47AM +0200, Michel D=C3=A4nzer wrote:
> > Then the developer needs to tell the user how to enable the debugging o=
utput
> > and get it to them. That's pretty standard.
>
> *IF* the user even notices anything. As said earlier, it didn't cause any
> anomalies on my machine besides flooding dmesg. Which I look at for obvio=
us
> reasons but users probably don't.

Right.  I think there needs to be something otherwise no one will notice at=
 all.

Alex

>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

