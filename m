Return-Path: <linux-kernel+bounces-776413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AA1B2CD02
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86EC3684BE7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DF03376A7;
	Tue, 19 Aug 2025 19:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dSJaK/XL"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C97D2773C1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 19:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755631987; cv=none; b=aIQGTinTI8oxMvBW925CnJeXVaQHuc9FuIRR4sIM0osjuAb2oZcX/X2opgYhOi7+z0ATB1D2xpoBjpL07/c9TGXbpMt6DTb/O4I/Q3HM0YmEnUeKHOpag0Bml4QAe557yXYSPy7sDK9g08s9da3iFplK1BYl/T4+llkyZ/p21QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755631987; c=relaxed/simple;
	bh=Dlc+gv/phCrMNJTD7pA0SvuOLHUdk1RTYlblxps6Ixw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NO+Hg6XGS/549qz2xwIdVisEBWgomOqRBzFgpdFgEMVq3xlbuRdiTQP0RtQEPp6S8JMu5Rou/2l9Pya6mRkAYzYEQE3+ctfqRc1bpwGkh9OAW5pIy8TDtQ6BmLGlEJXhV1FoMyGlLfbENHsnQdNT/ByAfF1oqLIKnKrGnDCs+cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dSJaK/XL; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b12b123e48so57241cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755631984; x=1756236784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dlc+gv/phCrMNJTD7pA0SvuOLHUdk1RTYlblxps6Ixw=;
        b=dSJaK/XLjjdkIlg8JnQYSU9gcXJdZATsA4dCEIJI3vfWY3BEVYPbTkQ90ZISFuEcGd
         TFgmrIYvuRRxusOa/Lh8s71TXhh65PXjFplPRipgty51jJW9zpN+Be+ze1RyixXxmOwl
         XKYbNfdySb1fP9vkrpKXdQpzZTUdULgGoR2ujho/yeKflkiOFcse7K6md9jryOc3iWCr
         ZeYFETYhXbq02CtDiwDFLRdbsXsztQsnp1WhNZplvp5tis3szI7yTBrRhp1IzsOfYfBA
         EzrD1xP/zvZ5KQWlxqyi6uHr6K2jNd0/dkgEBmQRl8K0DxZu3s8G2BSSpCv3DWTbth+g
         b3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755631984; x=1756236784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dlc+gv/phCrMNJTD7pA0SvuOLHUdk1RTYlblxps6Ixw=;
        b=n/Fcy6NnM7pdXax/GM+BcGtnEPdCJSH0XCgTJwtMdV2HsdVMXEZ1DFwEmOk/sU5bHt
         cGlJegXP7LJLhHCL+MFD7XfSftx4DM+j0FidoDL5bhyfWX9CnVTTqSFleYbS00aeiUXR
         TuWbc3xs8vMS3Qs4ByL6yEJeAoSSHwdqPrVjw+Fn2zmHfTynMobn+vU7Fxlz9rWCCoXH
         8M4FKJr3Uta4AUVEr2NfgCZQ86wMmN6yUqtMLnuxig2PGesHTdcKhb4qK3WZUL3QXCGS
         qzI4JSLAaM4K5pVK2baqkWCr8+UDkR8SYnOzuuXqYywS+/TWVBx/FwVXtA1DEjQm2e6S
         VkDg==
X-Forwarded-Encrypted: i=1; AJvYcCXFdjMzPutqbYfge0NZ4xH52MmNHBtchRffNCo9IvngdEsxtQ+/eCeVPcUyWGLF6XIV9eNUqr0f7pf9ou4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSLWuz2C0kY1MIQJprsWZbM1QqXEMW1PxvPqj7Pdmf/RAIrMO+
	B+pKxivQuuRT/DtNfk02ZoxSIKszi8N9VdPKmPtr4dGjIKFYnkbLuTxLKZTr6fgjG1/KE1Ev9Ts
	WUW8N9L9i2JKHZvdlSIjwFVmSkcw7spI775oF6Z9I
X-Gm-Gg: ASbGncvp/LRc1B4BLYngROLf9GFOc3ba5bylDTTRsXPbymAf9YSgYsa24d4oj8+6eXp
	xYdln48RhyjhmOuGoq6gQP0pywpxyRm3SJSNeYG/5MDeIMJP/SPmxKG+WaNBLVd9iAsOkaGsNrt
	nKst89qtulA+4pOWdHJDoH/xyQvB27mmamYVnEifjUoCOqCIYB88DEuOGBH0n9mqPXNWGtZ9j6V
	u9YOBxGOOPBQkRdfHaK7loObxUBO+REoHdHUPAs96OO+8WatceMGF0=
X-Google-Smtp-Source: AGHT+IFZOUs4HvSAXDicI6HRK+xenYcqiZRbzTDhlDFCbIHyzB/2YxgCL8t0otnlqVer1xfFluhajR27sxVEpthm9Bo=
X-Received: by 2002:ac8:5949:0:b0:4a7:e3b:50be with SMTP id
 d75a77b69052e-4b29190f742mr958271cf.16.1755631983445; Tue, 19 Aug 2025
 12:33:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755499375.git.asml.silence@gmail.com> <fab9f52289a416f823d2eac6544e01cb7040eee9.1755499376.git.asml.silence@gmail.com>
In-Reply-To: <fab9f52289a416f823d2eac6544e01cb7040eee9.1755499376.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 19 Aug 2025 12:32:46 -0700
X-Gm-Features: Ac12FXyzzAHQkZQwTmfShgjuBIC83fo8ZLZc42_ORo6YGwvB1xgCyklsv26SR98
Message-ID: <CAHS8izMPCOp8QeC9zZddBYaGSNd-9+CtV7XbKOn43pHb03vi0w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 06/23] net: add rx_buf_len to netdev config
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org, 
	davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk, 
	michael.chan@broadcom.com, dtatulea@nvidia.com, ap420073@gmail.com, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 6:56=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
>
> Add rx_buf_len to configuration maintained by the core.
> Use "three-state" semantics where 0 means "driver default".
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

