Return-Path: <linux-kernel+bounces-872848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CF170C122BE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 01:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7AB8A353AAF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5831E7C12;
	Tue, 28 Oct 2025 00:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VTMdbrzN"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33804A23
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 00:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761611549; cv=none; b=Z5M7JV8FPOVWu0mqoDBA7OHPffnxzsiImZnQacS9nSzOPv8rCEZHea4nk0C5PeEBJjEdgOE9vXryAe1tLFC5YSE/EqAw94wnfnjlUV0dQPD+7vCCsYOM5aAQeHYZrMAnZ7motpj6CF8Yii8FLLM7tVi2hMsm5IAMArZd9CGNi1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761611549; c=relaxed/simple;
	bh=sZliMbiRU5IJnJ0zaE4gY5+HIkp6n6SZ0ixcB4Cdxy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bMtZJEsnBGP8IHrUrLz9Q+lXxwkwfzM2afOQiS8jvsiF8+h/x6aGSXjSKcMtXXR1TZz77G0bCha1IAgjlHaU+eIUYG71ppFqZXwKZ3um1TsNAk1BnBPFR+Ha7AdCKP1wzqRDkGOeB8eMaA3GtxYbYIRNsLsQioXw1EW78fJVyjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VTMdbrzN; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4eccff716f4so148601cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761611547; x=1762216347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDGupZg9RAC3q75DNbAlYNiWKv+uKA1nO+SLuFhCPek=;
        b=VTMdbrzNhUyPF1yP4r9pK1vMwOutK7CyNY/DmCq3AW4O3Jw7hPNJX5nz+33PFbXdWj
         SOuuXhzrU0bXso5b+IJ5As0/cCSkmojkWEExqPT/Lh3+hd54rAIse21ZFrnoNOU+Z4CI
         rr/vzgeIINRpsi/u9L1/QV4jKugGikR+4p10GtPZCHpgiilta7MNMQmSY7XPc9VdfoLw
         1ARFzDD/UxG4yVrbd+PMyT/Ew2dc49yTZ7fateieKpa6WbEr9x+1WGTaEc0rzXwNrdam
         zJVBhlnbFEgbDSD5r4ld1b+/ZPeI9vZ/zgorFEBhAu4TloKXNPh8aHNCVxDzeDGwy5YD
         8g9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761611547; x=1762216347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDGupZg9RAC3q75DNbAlYNiWKv+uKA1nO+SLuFhCPek=;
        b=WOYwLfrbQLayKMCfYLoD8EJQmmXyw1YzWrQNERXrR3KU9HoVKzyNCQ8SEcx+tJFjZN
         Qyc1AqvnnDHFH+1MLMP8kAGDLklFbJS0HsCQF4kdf/NTfFr20DSEBO4QNmR2CaKy4xyb
         KKoKC9O/bz628g0HTpMvD9fyS4HUlIswFJduZJHHEVm98dhTze0Odo2QTBRkIV7ZXlCo
         EuhfHfZwZ4hd5LPWsSg4osnUmhihUlI5TDcJH7aBt5ydnm40W2trtpaYsmCxNmM3F2sw
         w1bZEw1xIXaGtV2BxIbLVCUT/SxevW/CwWEEIGfyYbVL5eaXNaFMA/5mbFyLjbbGCJO2
         yumQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEMxpi/U7M2flp6EWHWKUvL9WkptxpIIika8aR/mHakh6IXwXWyPSUtVi8hS1KuKY3KQhzMcfDj74zWn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcy/YaTn3k/hsMJtbUMZVdQKeAeUFarg6jTSgpdfDX7vVZp9ME
	dcSgdx7tZlOb8peJep9wHJcGDSOHgmB1pH1QPL6YW1H83NXL/UZavGhN87ZfF6EDmAnNqs/b/tW
	FPriVqKTbATrHfyGMXnya4Mn24yIqU20XESrjIOlUjhu3IbIkutFVh22a
X-Gm-Gg: ASbGncsPaYmSsV8hTtxE7yndfzeyyOvscJkFGzpPCHd4YfsDdnlX17evKD5oAYEsm5h
	Sx4h7Y6VhN1GekpRRd7BRFZAPnKGG1Nmy/36dWY1q8DClyRGvtkH2a3dU2rYrxcMIpVq1D9AX96
	rXDQEA6rDiuWJ6MAWZhgyVpNSQb3Ak6diLsDBzrzSLhxEw8UcQzgimzI7pD8Jt1ooc0qZW9WBrR
	1/9eCAzSHQQBLNXDNcJxLxjs0/nPFHTn2Fl0PLeSgewdi6lKlC1O/dnuU3S
X-Google-Smtp-Source: AGHT+IGhbJ+GHyeWlSzN6ycqAXLoxb1EC+qLGQ2vsQUvm5izxjzksoM3aqy/R23b67xhbshxeno45TIc7lJlqTr+JaM=
X-Received: by 2002:a05:622a:17c5:b0:4e5:8707:d31 with SMTP id
 d75a77b69052e-4ed09f4b74amr1602631cf.7.1761611546407; Mon, 27 Oct 2025
 17:32:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024-b4-devmem-remove-niov-max-v1-1-ba72c68bc869@meta.com>
In-Reply-To: <20251024-b4-devmem-remove-niov-max-v1-1-ba72c68bc869@meta.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 27 Oct 2025 17:32:12 -0700
X-Gm-Features: AWmQ_bmC9jAN48RJAgN8fH5cjcodcmrZUz535l1EvetlKGHj2iyHZZuQ7umrKFs
Message-ID: <CAHS8izN0nXPxpNDB=b=3dLMuf5KjGq_AswHsJ-XQDhMi7Y3WYQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: netmem: remove NET_IOV_MAX from
 net_iov_type enum
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Byungchul Park <byungchul@sk.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 11:03=E2=80=AFAM Bobby Eshleman <bobbyeshleman@gmai=
l.com> wrote:
>
> From: Bobby Eshleman <bobbyeshleman@meta.com>
>
> Remove the NET_IOV_MAX workaround from the net_iov_type enum. This entry
> was previously added to force the enum size to unsigned long to satisfy
> the NET_IOV_ASSERT_OFFSET static assertions.
>
> After commit f3d85c9ee510 ("netmem: introduce struct netmem_desc
> mirroring struct page") this approach became unnecessary by placing the
> net_iov_type after the netmem_desc. Placing the net_iov_type after
> netmem_desc results in the net_iov_type size having no effect on the
> position or layout of the fields that mirror the struct page.
>
> The layout before this patch:
>
> struct net_iov {
>         union {
>                 struct netmem_desc desc;                 /*     0    48 *=
/
>                 struct {
>                         long unsigned int _flags;        /*     0     8 *=
/
>                         long unsigned int pp_magic;      /*     8     8 *=
/
>                         struct page_pool * pp;           /*    16     8 *=
/
>                         long unsigned int _pp_mapping_pad; /*    24     8=
 */
>                         long unsigned int dma_addr;      /*    32     8 *=
/
>                         atomic_long_t pp_ref_count;      /*    40     8 *=
/
>                 };                                       /*     0    48 *=
/
>         };                                               /*     0    48 *=
/
>         struct net_iov_area *      owner;                /*    48     8 *=
/
>         enum net_iov_type          type;                 /*    56     8 *=
/
>
>         /* size: 64, cachelines: 1, members: 3 */
> };
>
> The layout after this patch:
>
> struct net_iov {
>         union {
>                 struct netmem_desc desc;                 /*     0    48 *=
/
>                 struct {
>                         long unsigned int _flags;        /*     0     8 *=
/
>                         long unsigned int pp_magic;      /*     8     8 *=
/
>                         struct page_pool * pp;           /*    16     8 *=
/
>                         long unsigned int _pp_mapping_pad; /*    24     8=
 */
>                         long unsigned int dma_addr;      /*    32     8 *=
/
>                         atomic_long_t pp_ref_count;      /*    40     8 *=
/
>                 };                                       /*     0    48 *=
/
>         };                                               /*     0    48 *=
/
>         struct net_iov_area *      owner;                /*    48     8 *=
/
>         enum net_iov_type          type;                 /*    56     4 *=
/
>
>         /* size: 64, cachelines: 1, members: 3 */
>         /* padding: 4 */
> };
>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

