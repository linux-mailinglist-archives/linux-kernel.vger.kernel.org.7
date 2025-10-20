Return-Path: <linux-kernel+bounces-860544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45894BF05F7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB6DB3B6C6A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEF22F6189;
	Mon, 20 Oct 2025 10:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mAjnA/rB"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2002F6173
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954536; cv=none; b=Y4cLkpv2Czwyd0R9w1PJbQxFxKNW/zatz63O0EFtC9YacIeYPZkmeOZNEu+uDdQWE1nV2ZZjtbHoq6PCsrrKOzOMERATS/FJtncYwlBROO3Kr5MV3sjs0OO/vAcpvbGWDwsnyQmzT8lt1Y89cQkINgJPtibuPdu8oDN+x8crs+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954536; c=relaxed/simple;
	bh=YZmkiE6IYqORaoMB85+7KlwkNWG7iNkrs2r7JhIoc70=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aia1N8RoBB5xc2kKdnBSK6oHXWdU/G5nLbRTPnL2ZxcKWLUTEyf0VMtF/dCzA/qgqGFnjAlxBG4w/uNrGt5FAUdbancbZJGloIae6w6qoDXSVcBMKLldA+HM3Qg09PmY/pUY1abdr4C3R1ABmewYi2osFhwID6fWvU4kQAOkI4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mAjnA/rB; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-470fd49f185so34670605e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760954534; x=1761559334; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ysWWL2E0S+o4/V8T/pUjhBkANb8o2B4A/OaGe1c7O/E=;
        b=mAjnA/rBeGBR5DmmGPM8Snar/MNkeUrVWf8C0YkfclbNhrmVdCMfVgbFN1gvRgdTqk
         s080PaWY3dk+t5JBweYqHoph6yHFHPFRWYYhlUU+Ei9RJRSDhzSrOZD+oBdck1ANhd83
         kq6gnbfc40f8VCDVAEsOInjXbm4GpdS/MJ5s0Rsr4U63MhsqQed38zK3dInC1Dcndub5
         aOIAyG81HlucO0yEsZn9cWAEWxU4GqLul2mMpJkn8mfxQC1Fae/1JwEgqX8sTqkKo90w
         F1iANrlR7NnjPgH7BM0imdWBrn1N8Y6lqmkYn96KW8lzAlX6Bv1cYwg1fMCZSuf8OqLH
         HDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760954534; x=1761559334;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ysWWL2E0S+o4/V8T/pUjhBkANb8o2B4A/OaGe1c7O/E=;
        b=m1qhZaIYcIfx68uz9J47nLN+Ps3P0W2WpDHN4yq7E64YAfla1FjVwGtioXX1CAX0yH
         x30nUos7xpecAhUGQ8ancZ73DWdIoaVAHWY9ofdqiO2iUkW+5K5M0+6Kl/7jIJG0mYww
         m+Tzg10+OsQMHFtX8VPVN92KwTXsm7ow6/JmhlIRV2/8RTtCX4LKs4dpz8jZwbV3aRzm
         gdbAD49Gf6HfF3K12MrYSinov5OK6LbA+SPV413DCu6XhyBCMUXPZXbw0tkV/6eYh+lN
         WZhS9/hIMKhdg7PbXChUZ9pplfdTxSLq+6N2B7zPmPiiuYPeKEptPGmyTYJ4qZEC3Z8X
         iIaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrF+7iMuZXtipBJqJ5gPoqXhNm06n7OhWSM+03SQRkCyvNoCoayG2cpmPckKO4zEwjKz8Dzc3woOatwF0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2HE1d5A/kLzOpHnT3DezEjO/1OlcRhMeUHj30RLdedpUmn/oK
	Xokx7rmDQutvvCr4Xdm6S5AzCo9+KOD4FnuM9YIHdWf/0OHPJHDaEyCCWkYSzr/tsQ65R6GHMva
	r9aK0Q0Nzfu96gaioIA==
X-Google-Smtp-Source: AGHT+IE0ZXAqseWyjpLgReO0ii0OIASivJqIvkm0bcKlmn/cZWguLy7rH50N9m4LwhSIfhdDKruNbEc2euHhR/s=
X-Received: from wmcn6.prod.google.com ([2002:a05:600c:c0c6:b0:45f:2437:5546])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e86:b0:46d:996b:828c with SMTP id 5b1f17b1804b1-47117879b8dmr83149175e9.10.1760954533559;
 Mon, 20 Oct 2025 03:02:13 -0700 (PDT)
Date: Mon, 20 Oct 2025 10:02:12 +0000
In-Reply-To: <20251003222729.322059-8-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003222729.322059-1-dakr@kernel.org> <20251003222729.322059-8-dakr@kernel.org>
Message-ID: <aPYIpGv1wDaKw5kn@google.com>
Subject: Re: [PATCH 7/7] samples: rust: debugfs_scoped: add example for blobs
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, mmaurer@google.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sat, Oct 04, 2025 at 12:26:44AM +0200, Danilo Krummrich wrote:
> Extend the rust_debugfs_scoped sample to demonstrate how to export a
> large binary object through a ScopedDir.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

