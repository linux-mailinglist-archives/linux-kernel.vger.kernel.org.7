Return-Path: <linux-kernel+bounces-809937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EC0B513A9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D220D179DFA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5DA30F7E6;
	Wed, 10 Sep 2025 10:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O8cpoh+R"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D37D22154B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757499443; cv=none; b=XZ5aH1Ocduz9dftbz2gIks26YYSRWIV0c5/EzlldkzpD7o6jwefO7MpgloOimawrksFyt/hZ+6LkmpB7ilXQyPnbQcIRG5HmFdq/Cn7QA3SS4R0RsBiiOeOtTxXiRYr9x+UZn8k2/W5Q/CCymzE3+DAtT/aX7Qm5X3O14ditmnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757499443; c=relaxed/simple;
	bh=xS4ckSmMKP8VWQ481D6mfsBHCl8BN3VaiCokSrHJOUQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eXSluOJsk1S9N3//+ZpgeF3L0C9f16PQixiYlCsIwDZX76LR8iMm65GuvZdVoMV1+S5B8fYEqFEHpSjC2C8948vZAGDRnP98/j2qP9r/0uZ9qb9tjJPrZAyfN4B7CJhbaVeVfkm01knwJbd/Oe0peoJ1PGCRwfXiDOzfnwKwT8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O8cpoh+R; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-62ae827e496so2461238a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 03:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757499440; x=1758104240; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9WFJsN/r1e5A6uZuKFX1dVizwYbiizrdc8crYvAgSBw=;
        b=O8cpoh+RLSF4w5ndOzuskn2M+b+1lmZ2DHhocvry7suSqK/Tf0+ybhxow6iGidNZwr
         QxxO8WE4p3k1VCa0/LRI227f2KEuO0AnIQS6tyJNAAYGovewxSjmBdpNMx94ZKv/lBRl
         dJybRoS2POvi5ui2kqqMicwOKQSDgI/zj4QlvyZOimAJkaDYppYkr/ymUHwvCl7KimfF
         zZQdwbUEukPz4DMhTT6uti4X3kdr3ny6poEPM24W//3YtDXynuXMiyCXH6habuyXjEgn
         oWu6Te8GQhe4gwv067SDWB4a/EL+C0S43Sc+FMYyttxLPiFB9ID7DA7clDW3ILeiCaUE
         cI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757499440; x=1758104240;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9WFJsN/r1e5A6uZuKFX1dVizwYbiizrdc8crYvAgSBw=;
        b=tzE5YAjpukkkzcqObd98AzogeioKuzCyfBa8RCf/8i0wsQp4ekDMjF5L4ICusmpvHa
         WXTDZ9wPS9OT0d/jdY/NH1Wm/9161OyL3d/v158UnPI1EjAQrzKrd4+D1LcX/TE90LRK
         spISW5XbvaGwlz00OEEwB7KtbL09sSTo5zsb7vKJfYXYt9BUAw00a/++uc83u2Mw72Gr
         3ZL2WKam+J0aF22Q6nQEUtc/LAPppNgi9xdiiQzK2kCwSi4ly0CJvRlmZETnZan7YP3B
         3tinjkmidjbLSNAei7eMJBuiCECbjfytFenDAa1gpqj0fQ2Gp1K1en8OSFSIJzkb1zQC
         m7Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUW/U31SxGMDxhjANNwfGeTMlwQv8j3HGykFAddML+FgzCkD7DFoRtpmNONezuAivJ/CxRK1zG5+5XtpjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFdR9Au16DhhSy1Uc3Dbv2uY8JLuUH9pf8v22d/8jTH1U5OgsM
	dGFkq6ofg3zm/GL2PIkY78Vf8G6ljB91OqD1tLN5bCu4p1MOdQgfCLvo1jbnyDER/QcqhuFPvVW
	PVEmdeFrASYcscV33bA==
X-Google-Smtp-Source: AGHT+IF5YUN3dimb8zptLPLvG6MVM+q31mkTY3j6lyy/ixyop8s5av/QNPhGHBZWNO0slK3VnOSEdgs11cdTy4k=
X-Received: from edbek8.prod.google.com ([2002:a05:6402:3708:b0:61d:1327:cad6])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:90c:b0:61c:8efa:9c24 with SMTP id 4fb4d7f45d1cf-623797a9ae9mr11851866a12.37.1757499440511;
 Wed, 10 Sep 2025 03:17:20 -0700 (PDT)
Date: Wed, 10 Sep 2025 10:17:19 +0000
In-Reply-To: <20250910100755.2361281-1-lossin@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250910100755.2361281-1-lossin@kernel.org>
Message-ID: <aMFQL-Hq1KvBG5lh@google.com>
Subject: Re: [PATCH v2] rust: pin-init: add `#[bind]` attribute to access
 previously initialized fields
From: Alice Ryhl <aliceryhl@google.com>
To: Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Fiona Behrens <me@kloenk.dev>, 
	Alban Kurti <kurti@invicto.ai>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Sep 10, 2025 at 12:07:53PM +0200, Benno Lossin wrote:
> Assigning a field a value in an initializer macro can be marked with the
> `#[bind]` attribute. Doing so creates a `let` binding with the same
> name. This `let` binding has the type `Pin<&mut T>` if the field is
> structurally pinned or `&mut T` otherwise (where `T` is the type of the
> field).
> 
> Signed-off-by: Benno Lossin <lossin@kernel.org>

Is there a reason we can't apply this to all fields and avoid the
attribute?

Do we have a place that might be able to use this?

Alice

