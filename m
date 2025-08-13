Return-Path: <linux-kernel+bounces-766511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF246B2476E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF8D97ACB4E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99F42F6564;
	Wed, 13 Aug 2025 10:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OSboYCJ5"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B082F49F8
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755081316; cv=none; b=SKBLDWD8yr0KMSEhbd5+MLEwGxUco30mJRk1pEbpGLKlycR3zuymF/NWZnFfaE2nTCGizZgBvX8TRXKihJa4jsMZy6hwZ5Y+vdAdpwvevi3yiuKpyxzv8bX8LQ6FX7GBlh92I2ntQEndyBn45rbtKnZ4xl9ad7Jc+j3qN3Iwr2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755081316; c=relaxed/simple;
	bh=ckoluVly0kJ47Y/ywXT1BdJP6swJHesj9uZRZgyEQOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVb1CZjFlObSYjcE+Jr9yH/EQhtCJNEqb8d+wqc9KW8wLlocFGhQrVAuMxMqRg3SAGAmiDyu0GwTd0loOz4KpEGnpLOucSCnFTR56GpaXGTN9M7LzRx2RtTa4zQgLFv+W/AR3+KTJyiYD7/fzZSxipGTFI4F0rGKJa5niGnDif8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OSboYCJ5; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 09BD540E022E;
	Wed, 13 Aug 2025 10:35:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ghfcZjZ4FCbM; Wed, 13 Aug 2025 10:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755081305; bh=Z0P275pqCjAXl3ThQT7+0XhwlEzDOtPNXiQ1EzOmuhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OSboYCJ5a0UXZf7Pq1NrP/ZphElSk+eMM1c5Bk66WME6UjdyA971o8s6i7gd7x+vj
	 FOozH4/2PxHnzkM23Uwc/Yi63J1R7g1LUbRIN3sw1du/JQvlc5V2RuEs2AiaZY+fBM
	 onuu/Zlu/G/f6j/y1UbqtMc7eWGgUaIYACjbzGEaaaOvTZfQC/oigXFkk0MYNdt8jw
	 3F+MaJbgVZNNuhSexqE6TlZQo0oycU2Ye5ioLEmBqTIc8xls53bLyesXwS1cZWNer9
	 fx0x0U0fCKORutLfDL9lCaY73lzinjoqfeK+kieNV263wluYf6BaNK2YHYIHswIuPW
	 EUawUfsF+Xj+p/04WpvSDcvxw39RNylD6KeNX5u0ujBmXiH2qYlAe4ubc5YKMW8cys
	 tazuCsXEnqDOSJKaFN/Pc3R04u/B76dxhMAHtmbJuwG0p8/fEdsLnQCJ2bvNGoU1mP
	 NDf0pIhjTK9kWv/rbRWt4PbJ3ilLL2ERidsneDTDO22xiy9XCYJVzecoq4pLnT3fDL
	 40PzoDjd6A9B0ZPWPqoV5Ael3o2HrmtNxfNafp0+/a2bXlYthBZpdRAWWb5iozlhrm
	 At1EOJHtw+MvJ3LZErnbCyIjRybaTgoYu/HQz55Zim/jEZCSOumm+9YbxvVIu4OUDt
	 +2oe5hum5xQpbg0DjHDhYZNQ=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 960E440E0265;
	Wed, 13 Aug 2025 10:35:01 +0000 (UTC)
Date: Wed, 13 Aug 2025 12:34:56 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, Nikunj A Dadhania <nikunj@amd.com>,
	Alexey Kardashevskiy <aik@amd.com>
Subject: Re: [PATCH] virt: sev-guest: Satisfy linear mapping requirement in
 get_derived_key()
Message-ID: <20250813103456.GBaJxqUN9ZTqx8wXo_@fat_crate.local>
References: <9b764ca9fc79199a091aac684c4926e2080ca7a8.1752698495.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b764ca9fc79199a091aac684c4926e2080ca7a8.1752698495.git.thomas.lendacky@amd.com>

On Wed, Jul 16, 2025 at 03:41:35PM -0500, Tom Lendacky wrote:
> @@ -149,23 +148,21 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
>  	req.vmpck_id = mdesc->vmpck_id;
>  	req.req_buf = derived_key_req;
>  	req.req_sz = sizeof(*derived_key_req);
> -	req.resp_buf = buf;
> +	req.resp_buf = derived_key_resp;
>  	req.resp_sz = resp_len;
>  	req.exit_code = SVM_VMGEXIT_GUEST_REQUEST;
>  
>  	rc = snp_send_guest_request(mdesc, &req);
>  	arg->exitinfo2 = req.exitinfo2;
> -	if (rc)
> -		return rc;
> -
> -	memcpy(derived_key_resp.data, buf, sizeof(derived_key_resp.data));
> -	if (copy_to_user((void __user *)arg->resp_data, &derived_key_resp,
> -			 sizeof(derived_key_resp)))
> -		rc = -EFAULT;
> +	if (!rc) {

Why is that rc test not right after the rc assignment?

> +		if (copy_to_user((void __user *)arg->resp_data, derived_key_resp,
> +				 sizeof(derived_key_resp->data)))
> +			rc = -EFAULT;
> +	}

I see a couple of places in the driver where this is done and that exitinfo2
thing is showed in-between.

/me goes and looks

Aha, the caller looks at it and copies it to luserspace.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

