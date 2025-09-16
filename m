Return-Path: <linux-kernel+bounces-819180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6061B59C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDAF53242D7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7538C371EAD;
	Tue, 16 Sep 2025 15:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Qo+NIX5m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA839335BBC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758037899; cv=none; b=qBnvYyeVrrkJKMsf1kt2BOvRGWaVLJlUrCD+K9j9mcRNTlZkzx3iVKAswRPvLdKlqOXauYqDiNhrM6zqBzxTHWJrGCnvoa3YFo00Pzc3/x2Cr5HDOvfDoUCMMwhgkUSRkGX9VVH6Pa88Euals1/TYS9ec/4Eir58ZnkZozOezN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758037899; c=relaxed/simple;
	bh=LWvtPY8JOaJUdfA6RqqgaTmXzD6Rya5jbmVIeuYMqlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uI/8siHowvMZ+xa4uyewJSpVA7ueVTxfUmAH/ZgTNikRF4K5AdBIUB292mBX4oQwJ7GGNmJu7kjUC7rTC9NgLdcx1D3ozIN61fcWqBAUULHF0VPq5QPPTfE52N/jf/5RGlWoMdtjRb58bjxxPfLgL4588Ox0ECAmu2MlH2DIzxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Qo+NIX5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E120C4CEFD
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:51:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Qo+NIX5m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1758037894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LWvtPY8JOaJUdfA6RqqgaTmXzD6Rya5jbmVIeuYMqlk=;
	b=Qo+NIX5mhGe2yd4oJbXiPz7RY+ol8CmGTpRFuJco7KjFapGtERQR/OjwbbZw2zeCD04y9w
	Y1W19Z/NkrHQLCNoQ93+Yf/Vv82M3IU40/LSqLp0F7XC+MWwOX9r5bLRt4Kg5H4dS1m3+j
	gsdUO5jODHhxBHhOQNsaRulnVeBU8UY=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id dc6fe9ef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-kernel@vger.kernel.org>;
	Tue, 16 Sep 2025 15:51:34 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-746d5474a53so1638112a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:51:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXiTM5AvxTEhjlSetZLnLfJlKFdbv8atHw76ibF0c2oE9tjNBHeN8CG+9J2ToEvLSVWAMIMkhcpqKdMEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YywvUhytd3iJPEHxJu6hnMDFGCQEVRKKsJcZoaYGWH2uds1Nzxf
	llQC/P8OEVsxkME1yYg7KTjfBwp58JiN/qsxhbEtGT43tlEsmHf2LqLf6qiO+RQLjGhsvpYTUv7
	DZk/Bi/NKryMFrKUcanWs0t1Nmv+ckfc=
X-Google-Smtp-Source: AGHT+IGP3SbAdOU4oqfpbda8n9JY4xGEouxACuVPUK518Vvhsmppkle9doyRfdV089EzJh2FTqLp3XYTq06dthgl3G8=
X-Received: by 2002:a05:6808:1b0a:b0:438:384c:36db with SMTP id
 5614622812f47-43b8d90d7c5mr7717876b6e.15.1758037892410; Tue, 16 Sep 2025
 08:51:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904-wg-ynl-rfc@fiberby.net>
In-Reply-To: <20250904-wg-ynl-rfc@fiberby.net>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 16 Sep 2025 17:51:21 +0200
X-Gmail-Original-Message-ID: <CAHmME9ra4_P0-FdVV75gaAWiW8yWsUJJsmTes_kac0EdTgnjHQ@mail.gmail.com>
X-Gm-Features: AS18NWBaLEA3oFeqxFk5qRFGjst8026RADBzbjhLf2Na8sHUXJEqAzutzDYhGUA
Message-ID: <CAHmME9ra4_P0-FdVV75gaAWiW8yWsUJJsmTes_kac0EdTgnjHQ@mail.gmail.com>
Subject: Re: [RFC net-next 00/14] wireguard: netlink: ynl conversion
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>, 
	Jacob Keller <jacob.e.keller@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Asbjorn,

On Fri, Sep 5, 2025 at 12:03=E2=80=AFAM Asbj=C3=B8rn Sloth T=C3=B8nnesen <a=
st@fiberby.net> wrote:
>
> This series contains the wireguard changes needed to adopt
> an YNL-based generated netlink code.
>
> This RFC series is posted for reference, as it is referenced
> from the current v1 series of ynl preparations, which has to
> go in before this series can be submitted for net-next.

I'm not actually convinced this makes anything better. It seems like
the code becomes more complicated and less obvious. What is the
benefit here? As is, I really don't like this direction.

Jason

