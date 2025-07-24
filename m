Return-Path: <linux-kernel+bounces-743637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D27FB10132
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9159C1C26E3D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 06:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EB3221267;
	Thu, 24 Jul 2025 06:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AdFQxbw5"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E55E217F55
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753340291; cv=none; b=KyJRe4583t+YIRThjD6m09GusD2UCjqI3BroScr7tbwW3cGVBWUhUJbKqrmnPIMLb+I838GAgO5w5gyI6+M4qAVoUJ1gskhAD8H2O9vL7NF/7BwHw0cy5U15RB7D4IY/qnkLMJb5w0jFzq3wfHAPivj+2VxQQs0fg5GJJYG6qoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753340291; c=relaxed/simple;
	bh=05QffvNA4rPYtwhetDKRaPeLYaWhowv2bUecmXeEbFY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dbmtjno6k8BNQnr2SANa6JWzzRQKMjvgr5tJ83ObHhQjI4S6ZWtea43kpx+TaUP0Sz0r+4SM3QMi1BQ1XD/jZIj8yq6yGuDx9VG9JXsRFV5P+C+gq1mFdPqrjnUuK8xohpBh99zcrwL8hB8bt36w49i9vbcxTwpKcqqNSuRMsIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AdFQxbw5; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45611579300so4029575e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 23:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753340288; x=1753945088; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xtb705LuhrRNByO7/3BfyZ546FH6Oxokz1gvWxJrhds=;
        b=AdFQxbw5PpbqaLtVcPuRvaYStpglZZx47HD68RR8pP5IJb3nA8C5izv5mwqPzM9Ixz
         1RNUu6HUxxcNcZJ+ZCWjJ7nvwAjWH1bMtyJH8oawdJO/gNsJzgCmjFERbptUEciFLm1y
         3gYSDZc0TbzNZgI0uORrokCFuO0qDoLYggMqbeUVsjtTSwT4K0C75h4PAl/D+RdgLK9m
         M0/IWtM1GLG+HTBrE+FfUjdTldgkoEl3RX5sOj+fvD8cX/h0lrNp8sWjOBv2yJXbSLu0
         9veYtJS3lkeqHErqVn+bhSN9hRdwSetlXLqBtTuPVC1kYn0G2mysCYYTIBXSFN6CFLNp
         1R9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753340288; x=1753945088;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xtb705LuhrRNByO7/3BfyZ546FH6Oxokz1gvWxJrhds=;
        b=HFQOnNdZXtuTICAMgasZmiHTY63lhhjxENjS9RxZBt0/kKg6QxJWdc/3kT+tEoEeFi
         E8hLrPr1jzNk+8RA00K60uGGDLN07dalGK+YLQbIlIf2fM4+XZGPiqaS2fdLBnw9YMrK
         EK4Vu1hePnn39LODAKZPPZVegXMM7ff9CLy2/aVN7TiwFNOYUlUnuBg2ZBiPnETChvjw
         73jwipaDbBoULGsz1hFTLw3UyhifE4AWFp/2ICHfX24cNwC1aCFP4yWKxXCmB3D5zZGB
         /L0396v42Qi75Pn2x55YAkqxvVQgj8ute1C5tHXp9fRjDRq5GDLX/+k/4rit8b+Z+leI
         Byew==
X-Forwarded-Encrypted: i=1; AJvYcCXsaL/n5UNvkquSDEzWaLu5J5KPBJCiIEj0Hkwv/2ULAzahEFqzBjf6uc/0qV1YtaOO+lxLuK/9z20UDcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV56KxGol9RLGIxcbHRMMgbcmg5gdd1qcKmORCLd5aRk0Z5WtH
	cksVfLX8kQC6RL/gDLvxkAtdpGKszC3JT+WxGa+NY9raCD+0mffSDcvX+rBFUqi7cP2D4+CwS9m
	BHAn1tg5W+PqEAgC+RQ==
X-Google-Smtp-Source: AGHT+IEscII00uUqVEaKW9L+u9v5p7LZ0jXP4YOUb0/cjjeMpcFBP7Hs7hcJ+xS29P/rW+NICnSqgvMZow8DgyI=
X-Received: from wrbce13.prod.google.com ([2002:a5d:5e0d:0:b0:3a8:2eeb:874])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5c84:0:b0:3a5:2cb5:63f8 with SMTP id ffacd0b85a97d-3b768ef3a6amr4464231f8f.29.1753340287875;
 Wed, 23 Jul 2025 23:58:07 -0700 (PDT)
Date: Thu, 24 Jul 2025 06:58:07 +0000
In-Reply-To: <20250722150110.23565-2-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722150110.23565-1-dakr@kernel.org> <20250722150110.23565-2-dakr@kernel.org>
Message-ID: <aIHZf5Xnb4QFLuKi@google.com>
Subject: Re: [PATCH v2 1/3] device: rust: expand documentation for DeviceContext
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Jul 22, 2025 at 04:59:59PM +0200, Danilo Krummrich wrote:
> Expand the documentation around DeviceContext states and types, in order
> to provide detailed information about their purpose and relationship
> with each other.
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

