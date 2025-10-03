Return-Path: <linux-kernel+bounces-841593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6D9BB7C80
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 19:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6B0423F1A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 17:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BD02DC329;
	Fri,  3 Oct 2025 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2XyMt33"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3AC24468D
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759513186; cv=none; b=aZogpJW03Je8uNE0IHeXtXjtzjf8Cp8TaEi9jKu/tsZbnyh0k0xPzKzPvjKwhJxu/av1G/OB/799hnd3lgQ03UegTpFw1DgBbsAV9C4LYiWEl7iPSZwZ2YogryTq+//pfI47OYFEKukKx4FK+LaruxeatvvP8E1IlHJ5FoCuE7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759513186; c=relaxed/simple;
	bh=rkmZOyEGwokVeWZxBu8CGNqvK5sClSggQ4njXh3MKtk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oq5xTNyZUtKCG6pGRb96sEklaiU5hldtYNanXTxfiuhX/l2wT+Ay4g6ar/MV57HDt+IS2AFdpzFFuE2fzV5UNwwgr0fEluH+2hOc5ETaV5e5/kIMxKdW+3a2v4NTb59IAtGSe5yDiOVwZEfoci2HzqJ0trJNiio2iedSevQ6Irs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2XyMt33; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e61ebddd6so23842375e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 10:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759513183; x=1760117983; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rkmZOyEGwokVeWZxBu8CGNqvK5sClSggQ4njXh3MKtk=;
        b=N2XyMt33M46tWcY4JYRV1NuK7tDXDeg99poy+1sm/KwJTcVHT7hTddNFeH4eua8VAl
         MnObc4x2EleFi8x//Pv2X12T0rYNebJj7OP3BTqt2IKlDmyio21kIJ/F/ee4SMt+aL31
         SL+pwP6FcyG1kt3fYOnnuphQXrqy29y+L2SresV5YEzjslbg0GyV8XOAbKdWgUkl4e3z
         Y0er0uWqOxz5P2cP8WT+zq4ghSqFB3SV6dXhjWd2IEpmFiZlah8VEb+PmZniD6RcUkaa
         zgIGVWgGy7cM9sbG/EgAXK8+Qgm09nUIW4q1bNCEFRNEvhXp+Q5Qd1QRCfhPIqXxXNsj
         pC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759513183; x=1760117983;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rkmZOyEGwokVeWZxBu8CGNqvK5sClSggQ4njXh3MKtk=;
        b=Qi2TsoJtjWshSeIV4hXOY4mVX1OYddcfnGUpbcbd7tE+l95VONEzfKUK2mAZIadXXn
         TZM8WKOllF6mA8VZoxacALcD3b+WWcaWvW6Qj/y6IhQLasVm3dHFrl8bOBeXRyeSFO9h
         IZ20RBZ/CJ147cfdZVEYDObFTMVMBpm/X2u/B54vp2+7/whm7MxttcbfI/w9ZtQoenhe
         XKiviCzJGEJmwo7ncjvJdnVb5AuktmRP4c8T7D9giRqySPUzGyOptatu4D0N8kMeYDTS
         FlINy7ic68KY+HLNuoJGsxz1LuTML5rPmeZR3ZJnqs71nqvn0HBl19IlP2EK5IDKQ3Tg
         V6Hw==
X-Gm-Message-State: AOJu0YyxuKqgrVaU76D9SwrKKhILEnVKMHDtQJMaKjW40VmgqugR02xa
	aKjccOuEucidXctReLu/bhoV0a620smUZq71KDHUt0gjJKHXOVGsRM3O
X-Gm-Gg: ASbGncs0oCH0Se7dY5fDqhzSVcmuK+IcQ7dOrSWt1RPCRNtIFeUFFOSiE9Ef16PIFYu
	nrmeygzvIKdn3q/PNgGXL15vAY6267dVgBvetO32ibe6ftoIUstbpncVZOq6KCCa7gzVFbiRaqy
	XkXfaVWpqHim0MoKiDleA9uylC1ZF0OlGHtcvSgRKoqv+gav4x7AInOlHuMDOp7R7aFjD/mpuMT
	Ci9ivlvNvDjoFfsVkISJyEpQ4qIuuLJpqzFQPmypUzYTl1eVaeUjIeE5cCgbJSjM/wXyYy2DWr7
	tPze9oK94ip4sgzFnHiTA35aH76r0uZNhYABuL8ftNXVvjkiG1kpJ3TXS8HmphAS9VCgfapELml
	7jvvXIOXJhW7A3gMLXxmDxzI5BdogmKCveWNMzMfxQtiBvipQcGNC8dlXCMazpyMJ5Ws=
X-Google-Smtp-Source: AGHT+IEuSki/XoM4rCKcaotfXJjqysypOd52m6IgtN6NTBsDMyUc4KvPqkIPo5OYOt/kydDekftJNg==
X-Received: by 2002:a5d:588a:0:b0:3f1:2d30:cb5c with SMTP id ffacd0b85a97d-42567154011mr2824129f8f.23.1759513183310;
        Fri, 03 Oct 2025 10:39:43 -0700 (PDT)
Received: from [192.168.100.3] ([105.163.1.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e9890sm8871298f8f.32.2025.10.03.10.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 10:39:41 -0700 (PDT)
Message-ID: <b109dcf89e3e1314224e5a29706154c2e612e079.camel@gmail.com>
Subject: Re: [PATCH] net: fsl_pq_mdio: Fix device node reference leak in
 fsl_pq_mdio_probe
From: Erick Karanja <karanja99erick@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>, netdev@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>,  David Hunter <david.hunter.linux@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <skhan@linuxfoundation.org>, Simon Horman
 <horms@kernel.org>
Date: Fri, 03 Oct 2025 20:39:27 +0300
In-Reply-To: <77f2a45b-1693-4106-8adb-304e0e818d82@web.de>
References: <20251002174617.960521-1-karanja99erick@gmail.com>
	 <77f2a45b-1693-4106-8adb-304e0e818d82@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-03 at 18:32 +0200, Markus Elfring wrote:
> > Add missing of_node_put call to release device node tbi obtained
> > via for_each_child_of_node.
>=20
> Will it become helpful to append parentheses to function names?
Yes, it is necessary.
>=20
> Regards,
> Markus


