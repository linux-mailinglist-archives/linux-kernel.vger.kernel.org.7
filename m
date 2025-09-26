Return-Path: <linux-kernel+bounces-834101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31482BA3DA5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 608817AC9C0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EBD2EDD44;
	Fri, 26 Sep 2025 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdHXWVe5"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61992EAE7
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892836; cv=none; b=XuUVdOr64uDjiSU4S52fgQ+f0fN8FwYHyJxgfn/8G63cmEcz7RBnzRevdFPlxZoTP7TNIK5+LzcNYRIbNyGzu0YYPFfq5b1VZfI4ItGrzswkZed6NdY29Fpb1DXQ+N1DIBbYvQWkLAR+u9cGlmtKgjlbjsJFw1f3lE5jfZTOGG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892836; c=relaxed/simple;
	bh=n7wUewDjvynTtSBbZU+T8+35uKQQNolU0fAx94eipmk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ijSQ7ooB92HB+78n8YUy04gCHGWTSgHJL7yXxVoCtAFw3+FZl2atl6Dt539IGPadS+t2+TeFWkLF1/3Z7Yf6Ga6zc7ZJEDykXJ1ngzYNmM7Q+oBS7A8YdaI5jkidRmHq+/2Ma04NEETuWNwbpesj/VFVuS6z6ImWbUkmIUnWvfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdHXWVe5; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-42486ed0706so10385735ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758892834; x=1759497634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exD+n9lmOs/QC0XvF7bmTazq5rd7UWP/ET+yH1yUt9w=;
        b=UdHXWVe5vxo8I1gHoiDV+ECdVipPvhWI2Qi/Y9sGCjuP6R8VlVDZ/he/d0TT2lHRFz
         mquMWDKgHICuyiZe1gdGz6YA7hgSCT+xVIk7GYMHldUFWMnIIlpgbKiOhBrFqFZGBYRx
         YhfYH15IgdPi+W9KV/JDoyrq4Uncy8ZNlYyCQPORnajSG6bNxWvUyMED9M627SR4d+mA
         sG2gEsETXFRVDP0fWiBIN1e/gl7HA+7OIcwCd7n442LaZQiTvs2OgIwq+RiUBzZVUKtx
         04/sC3ZvrPAgqhAAldh7C5dY1yQ+cXHG+g8L9/5dqN+oz8DVX0A4jsAOfGEXBYeCzeJP
         vB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758892834; x=1759497634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exD+n9lmOs/QC0XvF7bmTazq5rd7UWP/ET+yH1yUt9w=;
        b=KMUAFGHzeInu9M5oMrEJL6XcoXQR3hjttiD728x1aL0uU58/3sH2V4GqwIW7QMq4uB
         j5nAGN9UHiJkY9WZAhZ1WhCnh4stlp8b9SmopKAWrO7nxJDkdIyWs2CsfI/Oujf6iYWt
         eG8H67ULz3fgq7ynv7UMCYgZ8VwXNsNU/tSjbE3o+gqtYc5Bw4RHhwtwm3lffpCxoK5n
         +quQIQAuujsPFqTo6ftglEkIX72uJnYMdIyJe0gFODWWJ5JVKSzejtKwUXyrgmLzxZZg
         O+WZlMsalmbrWU68HB96Vr2pGoLhTeGV0pt8KBSW/PLwxHa6jLptG8ZuDKLQcXX8C88a
         1VLA==
X-Forwarded-Encrypted: i=1; AJvYcCWD+CQLknw2YGDF4wfS4Z6rLp1Giqzb11vKaLMIQAjeXita6wLwFbMJeM8s782H+1hUnEXhgIhaIrHQwNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7rdK96tp0HBerh44PuEIggXTpCkXyf6eq0trhUci9KSdpty7M
	02h98pEqhMOQ0TNs2TGXKN9S9UN83UFeCru2oz4SEfBpoqkaN8Ae2Y/M
X-Gm-Gg: ASbGncuLZPRzmHOa2w9NvoapR012ClV6NvXv9lz3Qc1CRvjJGCs2TNR6XeSNMv6YcNt
	yBMD+yiE8WeXQ/qB9xZ36OPyuVD4Yn9xvEKnf4e6EbRigKuvAyrkcGG1g1pp5v7dNeiceFy8uSu
	0Z3JJv3xTShy+YrAikrWZJN3QqAurAWEBlBB8YlPyKSR5MValaOgWzNtK14rfsA7yXGsrZNZCTo
	qox12lvolVoxe6AcJ3GRu9In0MD12+DI/66LGbFkKb2Id1sJ6ACHjm5sRZv56MVJKAdF64PPviv
	5dnNV8jQzALi3pckFTAnhko3c2TYrfGFJefuTbnXPNZ1FaQ9PcLN2MZ0SLTdpPsiNM6/Aj0PZ2W
	jGCaaaIQYTBvM70FyOPojWHjdD1bNYpKs
X-Google-Smtp-Source: AGHT+IGw0hM3Y3u9lAh09a4zFHGUlC2itz0RPoBCvFfYPn3BgjYRBhn8aTwtmMHq1kvbXiw9yl1Nog==
X-Received: by 2002:a05:6e02:1888:b0:426:7dd6:decd with SMTP id e9e14a558f8ab-4267dd6df15mr70598545ab.28.1758892834356;
        Fri, 26 Sep 2025 06:20:34 -0700 (PDT)
Received: from orangepi5-plus ([144.24.43.60])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-56a6546199asm1835028173.25.2025.09.26.06.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:20:34 -0700 (PDT)
Date: Fri, 26 Sep 2025 21:20:16 +0800
From: Furong Xu <0x1207@gmail.com>
To: Rohan G Thomas <rohan.g.thomas@altera.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Matthew
 Gerlach <matthew.gerlach@altera.com>
Subject: Re: [PATCH net-next v3 2/2] net: stmmac: tc: Add HLBS drop count to
 taprio stats
Message-ID: <20250926212016.4fd369b0@orangepi5-plus>
In-Reply-To: <20250925-hlbs_2-v3-2-3b39472776c2@altera.com>
References: <20250925-hlbs_2-v3-0-3b39472776c2@altera.com>
	<20250925-hlbs_2-v3-2-3b39472776c2@altera.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Sep 2025 22:06:14 +0800
Rohan G Thomas <rohan.g.thomas@altera.com> wrote:

> From: Rohan G Thomas <rohan.g.thomas@altera.com>
> 
> Add the count of the frames dropped by Head-Of-Line Blocking due to
> Scheduling(HLBS) error to taprio window drop count stats.
> 
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>

Reviewed-by: Furong Xu <0x1207@gmail.com>

