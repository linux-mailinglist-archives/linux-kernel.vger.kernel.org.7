Return-Path: <linux-kernel+bounces-860737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8682EBF0D2F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9BBF4F3B03
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5BF3595D;
	Mon, 20 Oct 2025 11:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhwKQZH4"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E850125FA13
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760959570; cv=none; b=mJrlxRiLeeSCOkUA9hvs8iQkygz5zmm7MfzkFQTCmvYN6siVxvySm+OU+bsb35cOc3casQYtGausuS3m2rtbShTRBtbTmhdlyZh4eAOlOyOrBSDJDo+QbWljB3MdMHZMl1JBorEptNkjqBjHCTlX6f2kzjJuBctB6tHqxpv65IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760959570; c=relaxed/simple;
	bh=hgOColYtjypJYFmtghZDQhWFnff6Vuq/Pns/rc/RTxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PzaYhSQN6WwMPKOiiE1ddNa/4ibai3MHbNb6QiV54Kmbmec26DFskVsSZY3SXOjxUFdFqYdwVvvcUOeBHdNF6umSxt0Hrql4pUnuAlK9vY7ERbN42qAlrgizueSfs95JoEvg/bdEXtRBZitW6BPapJ1/FTiwSibtWQdqz2cAI3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhwKQZH4; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-269640c2d4bso7726335ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760959568; x=1761564368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgOColYtjypJYFmtghZDQhWFnff6Vuq/Pns/rc/RTxY=;
        b=OhwKQZH4XCkNBxqdgYf8t4PRIoL0R7vfzMjrnIsRVCinoMnJNGTYlU79n7qlW8wfpa
         zNOeNBYKYP6/eYxWB/2sc9DemE26+rxb53oellKA91Nvv7rHQG0wJZCIgVDmJQ+2XEw1
         dEm6GoPgvuxODr7HArd+jLce17R43kU8183W8FwR/u1CVZTaZDg9vg818DlpOWT/z/1p
         k0dzpsWGEn5ROTH33AbNQbPizHs684iy59JSAW6NdXdsN2bxSG0/7KdSUIHh8JcgxNE6
         I3Hz76xnKnwdypq8mtZNQp2XGIGK2gn+JoMRHkY7nKIjO1OAXExZEZtqPbwJKVTae6vD
         9y1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760959568; x=1761564368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hgOColYtjypJYFmtghZDQhWFnff6Vuq/Pns/rc/RTxY=;
        b=mFTlec4prSRcICLzMRo8xIsTIYRinWLIIEDKnCLP77aU0h6hY0wOgo27Rlvamxinzy
         1TAFLqudKNgpVhhySdnZujfKsz3FrEYsTmMME9/pREduPutrq5ADV7ZWDw5IyCjzLnZM
         qOByuhPGP3C1v34GIBXZNvY0bhW850mD2fGnu5cYZPJziwP6wPUdnsfSw/AKvBmP/s+5
         msFs/tQWULS7MB4Di4fgdBkY/o46Ilfx751Ul8YOWSiQOJeAKec/29p95kRpxpRT1Yp6
         WHaCkM+dtQbSPiiqe4e6aqi+fGYQw+8U84bDgYLrLVodVNQwSfRXt1/iwSCZA8lOSGFh
         Adpw==
X-Forwarded-Encrypted: i=1; AJvYcCWdry9B/ApAS0W7pB6lC5C+ZtAxR4R9MEmvm1GMo+KzIPpxcS8TyLt69Sb3Esj8Dx46rsdSul4x3Dqr9b0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD5OYN9sc4+Cg4j6kFbvMt1DRfDcr4i0EdU5T6zptXxcEX8NZk
	t5zF3CEdm10KmiO0RwQvObvynkL6c0m2a5hQxHXn0VcjGn4kFDGxG9gEcuL8NS3JDiOup0RoWIQ
	PQ8agpwCFsHoQcNoDe8vEtMWmNfxCsEA=
X-Gm-Gg: ASbGnctjTf5KxYfryT5sTXbK8F1MUTgPvUc9qV0iU9BrzMJSevWTkOGvYLVAlHSJtRk
	evL2tVXUn6y9dsYNr4ng+zG4KJzVMEGXZ4tj7dH5MQba7+/hnmOnVkdffeWEv4QEvU/ey4G/U+R
	llH87In/mpL+QNpQnY7mTQo9l+U6ziNdhV5eev4LnyjvJRdUyVBO5/tvEZACwQWIbrIZjgAgsQx
	v+nypc3Y4POcHErzgcAtSwSgTWaXmOyBQ1npPLYGomMpk4vNpQ6wQkceso55ShoGdnRd8wvhG9E
	MZSJcwUfMKrpO1XGZm4Gn/NIkrOT43gy0FgaZzARoGsoJRd8esmHnzZPn6/H0rOEAw/BSBUwXwu
	Fc8vV+n46+6uk9W16ya+f0Iyg
X-Google-Smtp-Source: AGHT+IEKwZbSy/N18wL4YfpzGb1pRy6ao0FR9zqJgT5EVU+s2mj3AZEqw0jAcF02AG4TQ9WpRH8/nfLRy1ytZSe20ms=
X-Received: by 2002:a17:903:40ca:b0:290:55ba:d70a with SMTP id
 d9443c01a7336-290c9cf3306mr86594545ad.2.1760959568266; Mon, 20 Oct 2025
 04:26:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020031204.78917-1-huangsiyuan@kylinos.cn>
In-Reply-To: <20251020031204.78917-1-huangsiyuan@kylinos.cn>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 20 Oct 2025 13:25:55 +0200
X-Gm-Features: AS18NWDO0ydrU_D3vxY3mykKLDQk63GF017mZ_6ZLZcYagnPF_Cv3D8Dk6e5NHQ
Message-ID: <CANiq72=9=W_j_o=oT+AdghQbEFbEmqT+Gx6q8oK8-yVwcrnDXQ@mail.gmail.com>
Subject: Re: [PATCH] rust: acpi: replace `core::mem::zeroed` with `pin_init::zeroed`
To: Siyuan Huang <huangsiyuan@kylinos.cn>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	dakr@kernel.org, linux-acpi@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 5:12=E2=80=AFAM Siyuan Huang <huangsiyuan@kylinos.c=
n> wrote:
>
> All types in `bindings` implement `Zeroable` if they can, so use
> `pin_init::zeroed` instead of relying on `unsafe` code.
>
> If this ends up not compiling in the future, something in bindgen or on
> the C side changed and is most likely incorrect.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1189
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Siyuan Huang <huangsiyuan@kylinos.cn>

Rafael: I guess you will take this; otherwise, please let me know -- thanks=
!

Cheers,
Miguel

