Return-Path: <linux-kernel+bounces-731564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF97B05648
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712203AF222
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB82C2D5A18;
	Tue, 15 Jul 2025 09:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoZd1grT"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941E227876E
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752571545; cv=none; b=u+cnDuGTMf/oyqT3hkeG1vJbz+iZTJ4Yfble8U6AiZxjKek0zlx1Aqrx7GfEt9St81m6nA1S030scG1J7JAf3dNscVql3cqqqMG7nfV08s9o1javzw6yfsaahEepzpc9/uqvTlc8DfYglSJNoAn1IKjjwzPQRmoiZYOUv5KluMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752571545; c=relaxed/simple;
	bh=PFfpxVQeyUxYYxcdfqls8AqhMPmq1RJ55yv3O0fRkI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=DYRjHkLAxDBnMfuxy5uyAr2DblLHNjSOAyiiicB86Is7+mrChwZLkrSZr2KtjuXE2U+e0krU4zJpeY/BzRk7lnl0M3dB8x8xT5dJQP3JYqdaURszIUkD3Sm2xTfFOPAClM2pFCQrxh6gSz/hE0UkhyQa0h5OQ1NOPRVg9iofC5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EoZd1grT; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-70e75f30452so37320977b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752571542; x=1753176342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6iuHSGE/vZuISt3qNIpWnKcZ1D4onmuE4rPXHbKh0s=;
        b=EoZd1grT8i/Re27VmLjiKZQ9Sf/vZXT3VA5h+x0Xi/XAI1lIJybyN/Eg4jQFSnhNhl
         RA87e1Ke9n+EJmpBSyc/nllEDGJEbQlYx66NKFh5WTx+VnAW/wBtQsNTRyjNIY0EHv3+
         cT9Q+UnK1Ogjk6OgbWC7CAqCR5EwWtKaY+0KQpo5Lysb3BoGGfM4qae81n2D1NhcOrnZ
         74D31p0qh4OllWJpwIN1aXByN4rt+wmKmWj00AX8s/9AmbtogIgiXak+/5S5MswO8zU5
         rJKY7oxR3PN7XZNq4YtdDhE3Sg3d3snX0KNEkw/RundaU8TdAaex3qnFnwxKR5PqYupz
         uMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752571542; x=1753176342;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6iuHSGE/vZuISt3qNIpWnKcZ1D4onmuE4rPXHbKh0s=;
        b=qzpye8ykm+jJQFUKxCbDr/Z/sxxps3DPicI8v8DhHxauVw3pYoyxPJFpgYhOus5zs+
         p+n+faO6Vrp08269/9xD+a7sBCpBu7LpZCAmDdiEspmouIhHJDX/iuCT224PflxH1bC7
         8tsU+O14+0SR9H2GQ21EiMERKefEwq+NvurRcBWqFwkKLwmBTZXKYX9zmQGgWwTfnlna
         TvmC8eKJ1SxmPCNqs3i372WJXYhU3I2DHqROKoy/WhC4DMYUZURKiQdyg+VM7cBmcWzD
         MyqkEOwm0me7gSfCCNGe9D1ICb/MQUsUGfoV+eDYvV1u8xM73tg1vxzwSgjV4SLm9XZR
         UyrA==
X-Forwarded-Encrypted: i=1; AJvYcCV+jsochG+RbIGl1uNZKdYw7as3oVEsOX/KEHpn+XMe0EOEPkbSSkeYzN9iV5wnd8+GGhhCqqKQJCCneoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH9Zra0E+bUrazwikWIv3bTJd01WX4uJKjNxWnyVd5cUVd68KO
	owau7M0W3hNq4Q9Tgl3dFI7kU7VfsGDJ8/sWacJYDo64Tu5emzvOqHPT7WCmvtyEkwYnzEq9a8r
	CnsrCYzkJDFYU/VebSEwv+VlAk9EA8OM=
X-Gm-Gg: ASbGncu8xM4HBKtJ35dgXkJDXSd70KDCo43sFKEtqrmFi+WAeLdKVWA0AaZIjS2h2KS
	RI84fy7G0fsUF22YjDu6NA/xoKtKEfEXbQqEdnaIhNhXYKSrOv82UqxSVf4AN7YzknFvuidcrPo
	zk27fO5ts6rncMCR7YrFuEC0X3lnjSBXd5UePZ69RjDbmtNLrj1gzWj5ZOHr8/X/rbmBuKtv+cX
	lAux+/tceSZb/3ELbi/WqlCiSFcwo5sYKJAajvEm62vLac9zw==
X-Received: by 2002:a05:690c:9c10:b0:718:113b:a5c with SMTP id
 00721157ae682-71824af6ed1mt29005427b3.10.1752571542361; Tue, 15 Jul 2025
 02:25:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715091826.3970789-1-rick.wertenbroek@gmail.com>
In-Reply-To: <20250715091826.3970789-1-rick.wertenbroek@gmail.com>
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date: Tue, 15 Jul 2025 11:25:04 +0200
X-Gm-Features: Ac12FXzA95YgXoxLQ6f74t0E_Gn3zhZLRnGtrisY8g0SjgFtHHFg3IEcz3eTn5U
Message-ID: <CAAEEuhrtDcKfFF9NuME89tziuqYz4Y5fwepKE0kjSQD_6fzb2g@mail.gmail.com>
Subject: Re: [PATCH] nvmet: pci-epf: Do not complete commands twice if
 nvmet_req_init() fails
Cc: rick.wertenbroek@heig-vd.ch, dlemoal@kernel.org, 
	alberto.dassatti@heig-vd.ch, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 11:18=E2=80=AFAM Rick Wertenbroek
<rick.wertenbroek@gmail.com> wrote:
>
> Have nvmet_req_init() and req->execute() complete failed commands.
>
> Description of the problem:
> nvmet_req_init() calls __nvmet_req_complete() internally upon failure,
> e.g., unsupported opcode, which calls the "queue_response" callback,
> this results in nvmet_pci_epf_queue_response() being called, which will
> call nvmet_pci_epf_complete_iod() if data_len is 0 or if dma_dir is
> different than DMA_TO_DEVICE. This results in a double completion as
> nvmet_pci_epf_exec_iod_work() also calls nvmet_pci_epf_complete_iod()
> when nvmet_req_init() fails.
>
> Steps to reproduce:
> On the host send a command with an unsupported opcode with nvme-cli,
> For example the admin command "security receive"
> $ sudo nvme security-recv /dev/nvme0n1 -n1 -x4096
>
> This triggers a double completion as nvmet_req_init() fails and
> nvmet_pci_epf_queue_response() is called, here iod->dma_dir is still
> in the default state of "DMA_NONE" as set by default in
> nvmet_pci_epf_alloc_iod(), so nvmet_pci_epf_complete_iod() is called.
> Because nvmet_req_init() failed nvmet_pci_epf_complete_iod() is also
> called in nvmet_pci_epf_exec_iod_work() leading to a doubple completion.
>

s/doubple/double/

> This patch lets nvmet_req_init() and req->execute() complete all failed
> commands, and removes the double completion case in
> nvmet_pci_epf_exec_iod_work() therefore fixing the edge cases where
> double completions occurred.
>
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> ---
>  drivers/nvme/target/pci-epf.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.=
c
> index a4295a5b8d28..aad828eb72d6 100644
> --- a/drivers/nvme/target/pci-epf.c
> +++ b/drivers/nvme/target/pci-epf.c
> @@ -1243,7 +1243,7 @@ static void nvmet_pci_epf_queue_response(struct nvm=
et_req *req)
>         iod->status =3D le16_to_cpu(req->cqe->status) >> 1;
>
>         /* If we have no data to transfer, directly complete the command.=
 */
> -       if (!iod->data_len || iod->dma_dir !=3D DMA_TO_DEVICE) {
> +       if (iod->status || !iod->data_len || iod->dma_dir !=3D DMA_TO_DEV=
ICE) {
>                 nvmet_pci_epf_complete_iod(iod);
>                 return;
>         }
> @@ -1604,8 +1604,13 @@ static void nvmet_pci_epf_exec_iod_work(struct wor=
k_struct *work)
>                 goto complete;
>         }
>
> +       /*
> +        * If nvmet_req_init() fails (e.g., unsupported opcode) it will c=
all
> +        * __nvmet_req_complete() internally which will call
> +        * nvmet_pci_epf_queue_response() and will complete the command d=
irectly.
> +        */
>         if (!nvmet_req_init(req, &iod->sq->nvme_sq, &nvmet_pci_epf_fabric=
s_ops))
> -               goto complete;
> +               return;
>
>         iod->data_len =3D nvmet_req_transfer_len(req);
>         if (iod->data_len) {
> @@ -1643,10 +1648,11 @@ static void nvmet_pci_epf_exec_iod_work(struct wo=
rk_struct *work)
>
>         wait_for_completion(&iod->done);
>
> -       if (iod->status =3D=3D NVME_SC_SUCCESS) {
> -               WARN_ON_ONCE(!iod->data_len || iod->dma_dir !=3D DMA_TO_D=
EVICE);
> -               nvmet_pci_epf_transfer_iod_data(iod);
> -       }
> +       if (iod->status !=3D NVME_SC_SUCCESS)
> +               return;
> +
> +       WARN_ON_ONCE(!iod->data_len || iod->dma_dir !=3D DMA_TO_DEVICE);
> +       nvmet_pci_epf_transfer_iod_data(iod);
>
>  complete:
>         nvmet_pci_epf_complete_iod(iod);
> --
> 2.25.1
>

