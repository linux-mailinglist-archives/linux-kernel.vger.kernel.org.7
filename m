Return-Path: <linux-kernel+bounces-861609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26C0BF32DA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B762408107
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1122D2D1901;
	Mon, 20 Oct 2025 19:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kdd3YdFc"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1C22D4B40
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987967; cv=none; b=TEb7NgZaS40X+qSuWnfqXX4y3EUE+9hsQ4bLFVo1clC2JfirioswKbHOBX5HhzWkf2yT3ksNXkoOtzFnjNRGfGuh7AQS9tUN6dwxaqe7IQvozi6qEDuNRE54AjDxwXOLr5fVBkiDKjqWEamT9HDFMZh9wNMEWWUWZS2v20iqGZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987967; c=relaxed/simple;
	bh=YXpkBBmrwSLjuLYxkx+3i4ZtUHvDplauNtUTFwWBGco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q1/j3vREqvNfHBc4DTeMiSzYZyGISzzZxY6+LXD4b8gbq4JD0iU9oBWjrCAb3UWNQTIbhZ7yFFPivJd/9raYig2gsJ19MCbouI2+vpvtB45kj62u5D8H8DVBwzJ5wxLB32H1FgOUitxt5C3PEZY8vGAQnstYR1YSWIC4/G7ykos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kdd3YdFc; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5797c8612b4so7287551e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760987964; x=1761592764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXpkBBmrwSLjuLYxkx+3i4ZtUHvDplauNtUTFwWBGco=;
        b=Kdd3YdFcMyrvPRoxy4FtZJGCj9hQyARmmshnlMe3lA41voG47/kTWHTosvtnin9DBr
         GNrJwwhgFAR8swu8NsZO20DcnHn4uQ3PjqjFfRpQ0Lyi1e09IANp1xbX6Wb0O/a7MSII
         +/0uqxHMKFZeidtvasWZMjCyujXJNhpGS+uAYDRQdbDThvUCvXoLUe5Vy9bM9O2RIqhW
         szrXgSd8z33mdRgKgr893RnZvk3XbeoeYhDsE0fdtIcCwQETZX2utHC95pycz0p4whPZ
         +5ZRj6GSltJ71vBN3jfU0ktsX6mAxtEC51vnC1U6qXj/mJb5W7JKwl/qF115jdggm0+1
         D2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760987964; x=1761592764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXpkBBmrwSLjuLYxkx+3i4ZtUHvDplauNtUTFwWBGco=;
        b=BYwuV3uqpiKpV5z9C6sGNvE68X6xZftLxa3d5stZab/W2Z7Pdhs+u9QadI9OizOjtW
         8+w0NUC5RJZnshiKp8Em87aACWCYCPKq+xO0XWqz4vps9/WthvkAwUYc6D3KV7S37GL2
         pMRn7m+7PoTkxrDS5OF30/zGk4qocErp7gskmuxb10bsXaXnAyZeFwa0qg1C+lHlCeo/
         u+yuSYHXXUxOEskyJYKSs523rpcDEfAW6SWX7Bv7TWJr4jrJazRmCfp3lh8LfyqmzaVb
         UFSH+CeL1sh/yH88nz0xANNThW35I8cO19kPnPcXTuTyg5iyIoJ72eHJtRDd/MzAGb4u
         z+7g==
X-Forwarded-Encrypted: i=1; AJvYcCU3jLuYZhJo15fprBCPXugLUcnZ4/1oz3igxtTH32CTLPJFBwUuVzut1NazBHiBXNSISzCWTYOdJ7m53qo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa6uZapAR5MX6hGIZ9mgBqNEAjQDO1s9PgdKjNcu9/guP5dDTn
	PRWQEYl+jgHXOGmNl3RQ2udGRmSCMn/5/CwHjTX3Yty687jvaHLvKTxdJj4r/oJBfVg1FwCvTQP
	aEia56ZmRY/NoTLwTL9Nz69cmrxeSIhY=
X-Gm-Gg: ASbGnctkclGJCEQE/pmLesg5yE0kWjGhpX2ibu2rHH8iovBnmD8odjBVXoUZ/xxBaMB
	J0Rbn/L1Yf4L7lBGxrkqGGTTvcrOarNFRghMv9JpfwY5AkV9TFsgAL9MPlkvS5YO7pYDmUNuCzl
	+kFtVCKMYGaC5K68TKaZja3sjfBTN9vghlhPPNNTV6OeWlNPBl9Qiqu5ovZIGJKo318jqys1udD
	vTFYOCzg6zgyBihLsvQC0w/+U/dBFQh5SZB+Vym1NsK7ROGvY1g+axv5jWU7aWQcrmrJEXt1a2v
	R+Hn5IWHyo4JZBRoPQwKIyZEeZnF
X-Google-Smtp-Source: AGHT+IEvSQqoPC0w5PqHnyoNSr3taVqbpjv29jeiklwEL1fN7434TEmXmWt3EGss8QKd/DksBI8+cWWNCno4+2/Z7ZY=
X-Received: by 2002:a05:6512:1545:10b0:591:eb00:9795 with SMTP id
 2adb3069b0e04-591eb00988amr18089e87.13.1760987963720; Mon, 20 Oct 2025
 12:19:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513-tx2nx-role-switch-v1-1-d92ea1870ea5@gmail.com> <a3833c6b-5574-4aaf-86cc-66c10801ff3a@nvidia.com>
In-Reply-To: <a3833c6b-5574-4aaf-86cc-66c10801ff3a@nvidia.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 20 Oct 2025 14:19:12 -0500
X-Gm-Features: AS18NWDPp-wH8uYhmDLfsUgIzuO_wAf4YraXF5LgQ1r-UO3sGLpOYdxnVLvjeiQ
Message-ID: <CALHNRZ-wcEf-3ekk0wGxdGw0O5HiTnFUwFRxyKAikQkkWDjteA@mail.gmail.com>
Subject: Re: [PATCH] arm64: tegra: Remove otg id gpio from Jetson TX2 NX
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 8:36=E2=80=AFAM Jon Hunter <jonathanh@nvidia.com> w=
rote:
>
>
>
> On 13/05/2025 22:10, Aaron Kling via B4 Relay wrote:
> > From: Aaron Kling <webgeek1234@gmail.com>
> >
> > The p3509 carrier board does not connect the id gpio. Prior to this, th=
e
> > gpio role switch driver could not detect the mode of the otg port.
> >
>
> We should add a fixes tag here.

 Do I need to send another revision for this, or should it be added
when picked up? If the latter, this is another reminder about picking
this up.

Aaron

