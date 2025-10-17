Return-Path: <linux-kernel+bounces-857412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5DEBE6BE4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43AF03B6E49
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D32830FC09;
	Fri, 17 Oct 2025 06:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sE9rFpJO"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769D53090C7
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760683269; cv=none; b=k37b0sv2UQpvskqEi0HuIVsPWTbNAn2fkXYzsAmAsBENKXBOasu/rRuEcRHAebUwynVPvJ/XnCYO9cBe4bEcEBXbXa0CBbWebKfbCd1vujNrVzZzCmJZ/1GkEJPQEOpb5r2+mHlVxF4DDhttePAiuk5CmAHaOoTfjGdM68wH0rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760683269; c=relaxed/simple;
	bh=HEI/VMPAQm/lLBFNuj+LnsxSRZt1uuVXLn4zoDoHKcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VoosQUDvgOyOTUHafaK+QW/oU7zqFd70rZURO+WiqfHSMp4zQFq5VtzoXJ+mQKABpdJamqQIIK+1Kj6ShZbnauJTW4nd/R6aCRy2SkrXSozzDFsNTm3uW/g+JfQ3wysxQJAmch3XFp+43txE74nT+nSMAJ/871YVhaXr7knJ4Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sE9rFpJO; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-30cce892b7dso726265fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 23:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760683266; x=1761288066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEI/VMPAQm/lLBFNuj+LnsxSRZt1uuVXLn4zoDoHKcA=;
        b=sE9rFpJOw9BZSwEqrQJkclgfnuM/G+sYXQIBvAlgU2TujXaOYyX4GmOqvd8YZYBX5P
         OLEvTYtaN19xCbCfC9nXHvu2g0tlOjcIJZCukhkCC5g+ATmKbUuEJq7ES6UgDDK9PUc3
         U2B4BNfzF+PIstNo9kYuT0e1TeiREbipWMEQPvKih6nH3Nb9pRbaSD25VYY2OcDLCdoV
         5JjLtnzkRdkzt6kwpsaohFRsfIyMq9kSjg1A+52eu9REEmPJ8JEONe5Dq4Rnc4dDWkmo
         30ZXdbmR2/BouWEGUwaAUnXo0v2yWI7TP+4PPSDafqjiWsz41CJesNH+RQ4Yu9/MJhzq
         h1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760683266; x=1761288066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEI/VMPAQm/lLBFNuj+LnsxSRZt1uuVXLn4zoDoHKcA=;
        b=JSgSXTR1namVwTbJAtdtkBpwW2eApZ56956/aIEHzlX02XFdAJyv+do7SLCM5iO/Fj
         EVepLqAHkza8jbbYHoWixDYXnVMkL6DWWWHyevyixV1qMYQZsKbx8fbNhgx00BelEEER
         OOLVpg0fpIb5u/erbJ/JVdPQ73IVatMyXeRQO9Vttx3uH5s6mspMdaic4cMQpRvPf6QX
         B0aN4uVf9zqZlpcjzvqve5wbxbaXRvlfZqFPRi3McfN4bLAEHoY2GR9QUDHMBeDJ9qBg
         X557PWpZSxQdPyrLtd9FzYmaAyjCOpnJTCbQOJ90/kHsA4kpbiUA+u+C+DdAeXzd/lPl
         rStg==
X-Forwarded-Encrypted: i=1; AJvYcCU5+mApuqJcXo8Tzv9rRLLmFsETkTXpsCP8/jrph8nWOeckVt2hft5AGqT+2i6N+5CM0PFw0EDbVOngnfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgYvGFVQhtRcDcXFSD7q8TJ3aQzmYv2wkoXViUQA6GerAEaWEG
	IedAVT1+HOGnBn3t/Ef1xONbtM3XK4DLjgQ1fqgVoGO6UeZpsGoBt58VTWbauJAzF3PPhBYn1aE
	WwQAWmzVkWpwLe5cDrf837E+ChQZgUE2Drdje5caT
X-Gm-Gg: ASbGncs6k3CZjFj4xcCNLRM375DaDy2SSWOLW0j5uyFVE9N/ansiHs6kKftIhYyNnwD
	vp9EyaK2dTMv4WGRZ5XUrIIJQ8wByvLLT8GosSTC0uLzZeI+GOR6dpSjnDu/qZ3uap3pLXalx/Y
	hvBAxZB3lhoDLoQBSX38dO26P+Cg+ZvYNC1sXRrLDqvehtcy9hsYH/tegzejS1bUIl0zhFINYds
	oxwmeYXUgY/TQl9gk+Oer4h9bVzFHb846vMMcsnd6DbVathT7qAuUPVf5m/R6sCQ0leLlLwB5t1
	S5ZXObKICIdhLA==
X-Google-Smtp-Source: AGHT+IEVtA11UBYxqTUAD8SJlzk4igtsVuiFNGs1Vhi/4XOyirUuja1zneYwNbjp9heEcW9jRoymFU8GQqzMWhfMiik=
X-Received: by 2002:a05:6870:255:b0:368:e03:c3d5 with SMTP id
 586e51a60fabf-3c98d0fb311mr1107954fac.38.1760683266224; Thu, 16 Oct 2025
 23:41:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016232118.1419895-1-ojeda@kernel.org>
In-Reply-To: <20251016232118.1419895-1-ojeda@kernel.org>
From: Burak Emir <bqe@google.com>
Date: Fri, 17 Oct 2025 14:40:53 +0800
X-Gm-Features: AS18NWAA1df5ukuaz1ezqHuBrLDNG8qPNJzmhm1IkYGRA3GoDbqAJNDFS4-e_5w
Message-ID: <CACQBu=U6fDA2MHB3PsWe-+gEjcGKZs_hGftFKuLjhW2z3LnkhQ@mail.gmail.com>
Subject: Re: [PATCH] rust: bitmap: fix formatting
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Yury Norov <yury.norov@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 7:21=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> We do our best to keep the repository `rustfmt`-clean, thus run the tool
> to fix the formatting issue.
>
> Link: https://docs.kernel.org/rust/coding-guidelines.html#style-formattin=
g
> Link: https://rust-for-linux.com/contributing#submit-checklist-addendum
> Fixes: 0f5878834d6c ("rust: bitmap: clean Rust 1.92.0 `unused_unsafe` war=
ning")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Burak Emir <bqe@google.com>

