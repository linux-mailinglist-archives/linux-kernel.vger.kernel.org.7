Return-Path: <linux-kernel+bounces-894334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BD0C49C5B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C32C234A656
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF99A30216A;
	Mon, 10 Nov 2025 23:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUwjJA9W"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6A02DECCC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762817661; cv=none; b=SPZr9Ge7azZfVfSP/2iMqMktpHFoP1u6crgZC7BLfhdxdKxOciqcKiT8eDhDVKHuhhVhjEVx8u+SUkG2E42670VpCQ7nYVmoA7KGUhaXFxy/T2Uccj4ehL85ES7quLPQPE1Eci/PQJVJftNWMMlaGIoy8mL5ONygtG/VgsnmQCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762817661; c=relaxed/simple;
	bh=K/cQ2C7Ez8KzP7o1OrB0lJTjPYc31Lv7MkdeLsPQ4ZI=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EmF9Dd6x7cLBha56AOwI7FcDnDL8IovPeibCQJXMX5o5oAwDNmOzwHuxtYXqWU6EHm3nFDzdMcnyuQjtEzizlDVadIJjQLK7ppkGULkCKQhQYPgFo1IUXddhYHVyJSYiq1rl0/Pq74JGvfXPF/b9ivLL5fHe+A9trFseycJmuZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUwjJA9W; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-298250d7769so9055335ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762817659; x=1763422459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oy2n9G+dRBzJRRG/yf89aQd7NFJbeGk8QhHqO60fK/U=;
        b=eUwjJA9WWkc3CC8fxK/auzx2NRB21PokVYsBR7I3j74Qyjbiv2MmeRsMhkacCtWcxi
         tmFDeH3p1bva3gGWTVzMVBrHgvO2GrSvj/4qLnaJUKt9V64zddR+eLpaeTYsT4bC5aRn
         vWyQvVYP3tPAi23J/8VhN5OuC4EHmYzKfwyQBiWhbu5ZStTWbEaLucouODXpJQ85Y403
         aGX4Il4oeewRgnRfSEnxvq9blPtAd8nge6FTqCJznwEH99cjSe7Pj7MeC6sQBeXXBAKF
         flpq1RIOC6Y4flNpa/oNitWzDFuWULR+YhRvy9p35a2vxCH32e040ZU26UBnS3uJZOBW
         mYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762817659; x=1763422459;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oy2n9G+dRBzJRRG/yf89aQd7NFJbeGk8QhHqO60fK/U=;
        b=S1fTy8gPcHHjnl+0I3s5muItsHUHpcvrFDWACnkMAtrkICAz+iKhOP/IZ65jEek4OR
         Q5hoAyxQhd4De6kWj+vJwzHiJ92rIGbRF8HqfMnJSi5L9E0sFYHJ1It4jlFlbtWf8FDZ
         nBSya/pyJzSWULo+e/alaUT03RVgHUk4aP6r9YSBtyx9RZ7045o5MN/+Sw626aZDwpZ9
         PaBvNNeJyMo1eDuc3hf9FsKumeTMtiglKYvYpqbhX8YDOgf8ne8xD9RYAb2L6AOqW7E3
         i2KKYq75ST2QOE4mBPxkA2rkwk3eR2NrUYp8IAAyQ5eseR1geTGKBOnUd2gnpyXnWbm9
         JWzw==
X-Forwarded-Encrypted: i=1; AJvYcCUE/u1Ul0XspL16cjRQa/xTRS5H/8pkZQcaA390aTYVbmwdHTI8u36Pbc2b5yORYtgBKULvYRJhxc+bjyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7w1zSzl1mJbOzXzxx5Ugays6rAxd0XJhmXJOyhAaVO3+8raPr
	lMrrdadgyh0BQmK3BcDSviPY74byjE1I3xJhfhUtw94Svcc9YHX+fpaM
X-Gm-Gg: ASbGncvuD9jNdaPeSRgmcn/OHbOgNmmASoCMCiBU/VNAScmiAWww7JTxeIBJ+W9xir/
	Qnkia+jq2fds+WxInpRzWJkRd3ZXyOw401iwUdMcf1NGV/3RbMwEjaqdgkeEH7L752wBZfJlj4h
	EzNC961yFQDJzusZJhvOluafOl3CaMt9CE9xX2GwDOvHeYDUJB0Z9kn4c39xDStG0mrJ01uQhaH
	hR+YbhRPajeAQEK2j/xH0MzbLjIXYkuDnxjhMSrff1uLZP49TpTpaxXLuEniNCLVr1IOupaB4+g
	ZEziq1BUMPS2vuwPUcCpq75pXa8DxqymUBKRrrPlsIDkxvNyqfp5XDE3rgSES6dGfTfUZCHjlYQ
	LlKPGp9HgvhFuscSpygwNIQO3VIWWVOW+P8AAiOajkDzZFjU2LqEk6CGGrIhsUtDAZlEYh/XEiv
	ipnkexlVjUtsH4+JhPg+7JeOGpMoZSlqKFNUXIGhk0G8g7TsK4+RXocAjRdcvOX2sTjlpsZlodU
	NM=
X-Google-Smtp-Source: AGHT+IFfD56UHqe8xJ4zib+kMNCisvMUrImAWMr08SYb4N1rj4ajxA2f4+9t3KbkudcD1BAlAqplWg==
X-Received: by 2002:a17:902:fc46:b0:269:4759:904b with SMTP id d9443c01a7336-297e570bf23mr118686635ad.58.1762817658918;
        Mon, 10 Nov 2025 15:34:18 -0800 (PST)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297d4c54be0sm108297385ad.103.2025.11.10.15.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 15:34:18 -0800 (PST)
Date: Tue, 11 Nov 2025 08:34:13 +0900 (JST)
Message-Id: <20251111.083413.2270464617525340597.fujita.tomonori@gmail.com>
To: ojeda@kernel.org
Cc: fujita.tomonori@gmail.com, alex.gaynor@gmail.com, tmgross@umich.edu,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 dakr@kernel.org, linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 2/3] rust: net: phy: make example buildable
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20251110122223.1677654-2-ojeda@kernel.org>
References: <20251110122223.1677654-1-ojeda@kernel.org>
	<20251110122223.1677654-2-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 10 Nov 2025 13:22:22 +0100
Miguel Ojeda <ojeda@kernel.org> wrote:

> This example can easily be made buildable, thus do so.
> 
> Making examples buildable prevents issues like the one fixed in the
> previous commit.
> 
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  rust/kernel/net/phy/reg.rs | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/net/phy/reg.rs b/rust/kernel/net/phy/reg.rs
> index 4e8b58711bae..165bbff93e53 100644
> --- a/rust/kernel/net/phy/reg.rs
> +++ b/rust/kernel/net/phy/reg.rs
> @@ -25,7 +25,16 @@ pub trait Sealed {}
>  ///
>  /// # Examples
>  ///
> -/// ```ignore
> +/// ```
> +/// # use kernel::net::phy::{
> +/// #     self,
> +/// #     Device,
> +/// #     reg::{
> +/// #         C22,
> +/// #         C45,
> +/// #         Mmd, //
> +/// #     }, //
> +/// # };
>  /// fn link_change_notify(dev: &mut Device) {
>  ///     // read C22 BMCR register
>  ///     dev.read(C22::BMCR);

I think that some code begin lines with # for use lines in a "#
Examples" section, while others do not. Which style is recommended?

