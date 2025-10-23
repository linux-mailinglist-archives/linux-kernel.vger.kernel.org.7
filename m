Return-Path: <linux-kernel+bounces-867504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECADC02CB8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B21F1AA2C81
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA4034A760;
	Thu, 23 Oct 2025 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQzubiDz"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD07030F80B
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761241811; cv=none; b=sJPXVwQLTVhr/L6nCjrGXloe0R7J1JRgR7z8ZDm7PZiLgFoJp9MW7JssQj2aU/XlfyJ+zw50vRPsIu9H37aNVrP4XUKzh9QYUbCi8OSdKNhcw6oUd96ssQ00FuiX0Doh/smS2b6uDQ9JkrpLPpiH0EsdEd1nuzyLRdaXdgOiZIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761241811; c=relaxed/simple;
	bh=rmrFSVUHVZINnn18mE9h8LqSYST7xKMxaZNupWgxrjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k9rZsblk0Ob09isy1d99lQfSMheypaH2P353NErOxzvEL52MgCztVZsZ7k9rSyOEPATTeiqq/tt9Q2llTGErVpHV4pyDvvFzZoHU710qLfLF52ZIQtaXYD6V4jULvTaQ3FGz6VoUDYrSgZ44o/VLJJ7srzaLayqS37mDS4V1V/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQzubiDz; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-932dfe14b2eso829499241.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761241809; x=1761846609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmrFSVUHVZINnn18mE9h8LqSYST7xKMxaZNupWgxrjM=;
        b=JQzubiDzmbNqDV95lZrTIg0yptiLGpTeX6V4I9YJxmaCMp2E0ScVVrmK3VOj33J4gd
         EARbc4fNIgtpmI2H3/h87upSkmLx6YVmyIemn/eXusXQEs/KzvrO1l6h5bFR06A6u7kx
         Xv9nDKoJnfDfsWrhJlY08sVfkhFA/KWz7fna29L0X4dVP9MeQV2coonVBN56DMDpqCN2
         nG2OG/II5c5bMmEPXY+AM1xZc91aHXw0BNcdzrlxuwdxa1Y28ScuHds8rfdX7o6BUIvR
         GTWj5vkcE3fbr9ok/68a3VDU9Zmrsx4R9RNtNqlYW1kiaRmcoGJxTeWwDMNuof9gOTOt
         g87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761241809; x=1761846609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rmrFSVUHVZINnn18mE9h8LqSYST7xKMxaZNupWgxrjM=;
        b=pZFF+OYGSDzsStrMJ1KMNT6Bt5obAlF/rGHjOEsw6JzU4rVi+pFG2OYdadRfI/r4IT
         h9DpAPSExieCpFSUsU+ISRtLBRY+iTEv6YvqhINsi1A4zlRs/m6jsj+klzV7u4RTeC+2
         Xfm5KNh2JJ5YrY/cghxcMrbunWsRKOHku4Zu4HdiXf4949NZYPr7rIMehxZ1DrX3xlei
         WsWSeJjPyt3Ffzzs0RO55WgpQL/xpeXkL+P+y2ZZgqyz/t1H+tNeKq/3lh7QJ2n00vca
         wS9AMr07t2Ji5tp78Nqhf7JMHBucDy4fcSHL3zwGmr1RqGGj0j7xoGGICONymO7vCLLo
         hxBg==
X-Forwarded-Encrypted: i=1; AJvYcCWJftNjRJ4FbiaamwNpL2wPXGjiXju1tZCBrXQ4DStQz6E1inTt4BQQ6Vkm1mZKSiz+jpp25zx237PmhRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBMp4GbFYFd1qRHuPCVHnSGiKhxH9ULcsqkwh37mtN8hLFSzmN
	KzGnHRFB6L4plwdRxb5CId/sSFeeg61eIGSWm8nFfP593nJ/bcc3vGVAaFZXTXon2WhSA8exIvU
	BgsHjt6PyDayatJHxrcowKQyOdoMftBA=
X-Gm-Gg: ASbGnctbeUJbDEJp4U83IdLYDIh9R5GLs7u20a62eyPp5Iz1aRjxqTwifoUfJOPbrks
	RJdqRvsdhtHDopdpubIDdi2GXXacdONWxW+oAdQstMwOHRQuDFP2ymRuzKQi4GDNSvX7r84dkDq
	Ru5kJIRelBT5rW3O0p3+iSPbiAE9tUs4RMULxDAlvKCwt/qRw0w+9C/Gk0tFPxYJ8K7cvOYJPuq
	0RVmrvJW/3VambLgD1K927xxea/xs8B85AIAtbN4L307DPdj3T3MG/6+8rcZBC5PgkbgmQLjumh
	6BFCreePQSWzIXynIyaEwu8vm3OCod1m4PuNVTs/
X-Google-Smtp-Source: AGHT+IHpRyuoav5lJWR6O5jHg57c85VAu9Fw0WMge5AnlPcPoxSh3EP98NNnI6EblMA4ody0QL3Q+Pm2+edFZxbqWC8=
X-Received: by 2002:a05:6102:5cc6:b0:5db:28ef:3dfb with SMTP id
 ada2fe7eead31-5db28ef4bb5mr2325429137.34.1761241808691; Thu, 23 Oct 2025
 10:50:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADvbK_c2zqQ76kzPmTovWqpRdN2ad7duHsCs9fW9oVNCLdd-Xw@mail.gmail.com>
 <20251023173801.11428-1-vnranganath.20@gmail.com>
In-Reply-To: <20251023173801.11428-1-vnranganath.20@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 23 Oct 2025 13:49:55 -0400
X-Gm-Features: AWmQ_bkWcF1bKMfuE_JeO2G03ig-UJSmO2Qz1WYBH2Xg-mAv7cSejiDOLi0AucQ
Message-ID: <CADvbK_dJpnjZS_UjoM-D6xRhdhq_uH0FBBbr6tN_7qKih-7zKg@mail.gmail.com>
Subject: Re: [PATCH] net: sctp: fix KMSAN uninit-value in sctp_inq_pop
To: Ranganath V N <vnranganath.20@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	marcelo.leitner@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 1:38=E2=80=AFPM Ranganath V N <vnranganath.20@gmail=
.com> wrote:
>
> Hi Xin,
>
> Thank you for the feedback and response to the patch.
> I would like to know that above analysis is valid or not.
> And do you want me to test this suggestion with the syzbot?
>
Yes, if it's possible.

