Return-Path: <linux-kernel+bounces-729906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B16B03D5A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B62AE3B6913
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFB8246BAA;
	Mon, 14 Jul 2025 11:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuW58WgX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A961A2545;
	Mon, 14 Jul 2025 11:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752492501; cv=none; b=JfunUa9KMSEpCnSmYFLbGJailjTxsCt+ZpeMalXOkJ6Uq6SxIqTc11DIYT5TR2ch3fAsJ1xrPKtMt+8sWk0gL7N0rtMwnrEo6bKlAF4LEuKHe6/dXikgnrk0hqhGC+kjGVcUrBzR2BYjptbrQWFi5dQZSV/ds8jymWE3aThR3lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752492501; c=relaxed/simple;
	bh=sZqTm7pgCVsziSTCEnOE9O8yssbVDX/uReiosYE1Osw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=LeIlVbFAf19glZRnf12Sr45KzuSl4ZfKxBKULKgXVgTSVRM/juObbU76w2VrzOHmG2gIHH+o8kMurEL/qy/HFSRCbP0LCmLFwQSN8ty1atW+eKffax7vDp3vykHJq4DQ2wU+6e1ppjLYBUBcVYqQ8ETvsypvSNKxmGkydm+4xOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuW58WgX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F58C4CEED;
	Mon, 14 Jul 2025 11:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752492500;
	bh=sZqTm7pgCVsziSTCEnOE9O8yssbVDX/uReiosYE1Osw=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=HuW58WgXG2BbO8yPE9bYbXlpN6MZJs20fuVRO0SaqTY1sNDGwNzaHzLkFfGd+KLfx
	 rtaavlFYjZAAWQ+gHOWz17SiTK3NetlUcYZlcoswyddEspEhua2iYvuTFlHd7dnTTR
	 J8ZKE3j6n2BOMj3QQr3nZwkNFZm7ZG6TNVcGV60vUopUaGS3IMu0pEdamJJOvcDQF2
	 PuNQWr6wyu5kE5Xzr97AaVlHMJp727dkS6nU5GwMSyKE9yIWvJ+6hq3a99jbQN3Z49
	 IUabrU77rVU6uCfjkGbNNUmV4hVEg+Y6dbz6Ckj/B3o8rwFII2vYNwfy6CIxLz135A
	 8olHBUGzGR7RQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Jul 2025 13:28:17 +0200
Message-Id: <DBBQQQVVCTAC.I1OXFG4SVLRO@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2] gpu: nova-core: vbios: change PmuLookupTableEntry to
 relax alignment
Cc: <acourbot@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
To: "Rhys Lloyd" <krakow20@gmail.com>
References: <20250714110229.141221-1-krakow20@gmail.com>
In-Reply-To: <20250714110229.141221-1-krakow20@gmail.com>

(Cc: Joel)

On Mon Jul 14, 2025 at 1:02 PM CEST, Rhys Lloyd wrote:
> Instead of the data field containing a u32 and changing the alignment,
> change data to [u8; 4] and convert to u32 with a helper function.
> Removes another magic number by making the struct the same size as
> the data it needs to read, allowing the use of
> `size_of::<PmuLookupTableEntry>()`
>
> Signed-off-by: Rhys Lloyd <krakow20@gmail.com>
> ---
> Changes in v2:
> - get_data helper function renamed to data
>
> ---
>  drivers/gpu/nova-core/vbios.rs | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios=
.rs
> index 5b5d9f38cbb3..339c66e63c7e 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -896,21 +896,26 @@ fn try_from(base: BiosImageBase) -> Result<Self> {
>  struct PmuLookupTableEntry {
>      application_id: u8,
>      target_id: u8,
> -    data: u32,
> +    data: [u8; 4],
>  }
> =20
>  impl PmuLookupTableEntry {
>      fn new(data: &[u8]) -> Result<Self> {
> -        if data.len() < 6 {
> +        if data.len() < core::mem::size_of::<Self>() {
>              return Err(EINVAL);
>          }
> =20
>          Ok(PmuLookupTableEntry {
>              application_id: data[0],
>              target_id: data[1],
> -            data: u32::from_le_bytes(data[2..6].try_into().map_err(|_| E=
INVAL)?),
> +            data: [data[2], data[3], data[4], data[5]],
>          })
>      }
> +
> +    /// Construct a u32 from `self.data`.
> +    fn data(&self) -> u32 {
> +        u32::from_le_bytes(self.data)
> +    }
>  }
> =20
>  /// The [`PmuLookupTableEntry`] structure is used to find the [`PmuLooku=
pTableEntry`] for a given
> @@ -1037,7 +1042,7 @@ fn setup_falcon_data(
>              .find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD)
>          {
>              Ok(entry) =3D> {
> -                let mut ucode_offset =3D entry.data as usize;
> +                let mut ucode_offset =3D entry.data() as usize;
>                  ucode_offset -=3D pci_at_image.base.data.len();
>                  if ucode_offset < first_fwsec.base.data.len() {
>                      dev_err!(pdev.as_ref(), "Falcon Ucode offset not in =
second Fwsec.\n");
>
> base-commit: 215a3f91713383a3c0d2da82d223a608a3c17ac1
> prerequisite-patch-id: d80f92d314a0693d4c89ffb7810d9ab6990336fa


