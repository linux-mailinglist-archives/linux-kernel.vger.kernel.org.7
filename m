Return-Path: <linux-kernel+bounces-891777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3697AC43715
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 02:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 00EC34E2099
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 01:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE09519F115;
	Sun,  9 Nov 2025 01:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tseue9iF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52480AD51
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 01:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762651972; cv=none; b=WGNPJMGaERDpbL/X9+QL0aDyDpdKrCL9pYbkyUBg0axCKldQYlDlO2Zi64Nj0La4WPuWP3wvd+zchbJHWIgIsAVo1BJ0w4Tr9NoQQ366w+H314LTK6JRmeRvkQf8RbD4SCV5/TXgtBs9FCu6KRocYUL0C3TxREsEi0YlcgPLRnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762651972; c=relaxed/simple;
	bh=JLDqV8ezX7r/6cFHYwMMco/iyixfBO8kA6xRqCIgak0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMx7ofNQTd6VxH+HdjrBOEXWhCJG/bqsqMw3VQzyOkM4sKGQzyLX4kGG4iH1RFCpi1QhA51JiYqReRFeIw931yx5uRfsx+SKd2iVRsjfiYRty/klZH6icDySwBi+r5ZcxmyLqujntG0BsjMWbs88HzUSudxttQ+HgBka2mJ9gfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tseue9iF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D58C4CEFB
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 01:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762651970;
	bh=JLDqV8ezX7r/6cFHYwMMco/iyixfBO8kA6xRqCIgak0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Tseue9iF/XsTqddA/n2eiYdGOL9xB5VwvXusYMlOOCeD9l9GjP4zzS8/BPalTFG0e
	 BAg7zKhf5g5qK7V+bgY8DqfZsJNKsfk8pYmtfGUZszQJFzOMpAkNH8VmC4m6k+W0mg
	 hhk94oI3NK6bVMyY+oZFMjucSWZzFlmrDS1genhoaMG2ApWDqR4gk0V9SMB3ed5QuS
	 BYwttlBm7DPZ0f6UhKJ4ecNFwyMOZBK0pHFZm2CbpucecMOMq4jVfW3JllLUSGReOU
	 LH//cABc57A0GkSNuy98bgT16Uq9a7cu9CCAuDIQk6Omf3PSd8kYUdbzTR6qBIkbtn
	 /ZhtFoU22JTqg==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7291af7190so290418466b.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 17:32:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXzQJDiQfDtSW+/5zy3EmwTpHsOWSGkF1EM5DT1TFxLQi1pePuQgwyDKH72JwmskaAyqhk4wbft//lkJK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJFl2piCVa0AWJBxta3C/HVvVqXqHjw4meQfFo0JVPIHlAcD42
	Ia40NUpano6KYT56doHxq9A4EARDEnyZvKovg559ZivUVR1QQZZ/MEHKOr3yIKBR2R8+CeSb6uC
	5c75v0/3gxXLtfcJYp1L006UjYGkQLuM=
X-Google-Smtp-Source: AGHT+IFwE0YurAS9EBuOH/BTK/I2Z5iOVtiNvSMR5NXl4i1e/jRjGd1XBWjtYC10l/5GnGiHdMouahIIkUWnSFvo2LU=
X-Received: by 2002:a17:907:7246:b0:b72:5e29:5084 with SMTP id
 a640c23a62f3a-b72e02729dfmr390481166b.4.1762651969360; Sat, 08 Nov 2025
 17:32:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKYAXd-R8NGDzQ-GTM67QbCxwJTCMGNhxKBo1a0sm0XBDqftLw@mail.gmail.com>
 <20251108155712.384021-1-pioooooooooip@gmail.com>
In-Reply-To: <20251108155712.384021-1-pioooooooooip@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 9 Nov 2025 10:32:37 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-SSBbW+FhC7mHYEh1JLFRVNyNOLiogbj=Nt1eszxf2vw@mail.gmail.com>
X-Gm-Features: AWmQ_bnHIIwGraT7R8ro6xvCocGSJ1L8DonF5ZezAsU__d-y2HYgoO6DXOrC-NQ
Message-ID: <CAKYAXd-SSBbW+FhC7mHYEh1JLFRVNyNOLiogbj=Nt1eszxf2vw@mail.gmail.com>
Subject: Re: [PATCH v2] ksmbd: vfs: skip lock-range check on equal size to
 avoid size==0 underflow
To: Qianchang Zhao <pioooooooooip@gmail.com>
Cc: Steve French <smfrench@gmail.com>, gregkh@linuxfoundation.org, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, security@kernel.org, 
	Zhitong Liu <liuzhitong1993@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 12:57=E2=80=AFAM Qianchang Zhao <pioooooooooip@gmail=
.com> wrote:
>
> When size equals the current i_size (including 0), the code used to call
> check_lock_range(filp, i_size, size - 1, WRITE), which computes `size - 1=
`
> and can underflow for size=3D=3D0. Skip the equal case.
>
> Reported-by: Qianchang Zhao <pioooooooooip@gmail.com>
> Reported-by: Zhitong Liu <liuzhitong1993@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
Applied it to #ksmbd-for-next-next.
Thanks!

