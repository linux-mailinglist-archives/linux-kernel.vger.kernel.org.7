Return-Path: <linux-kernel+bounces-813940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F420B54D51
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A0D188415B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D08932BF49;
	Fri, 12 Sep 2025 12:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9dImwKX"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD87327A09
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678939; cv=none; b=HEviocBPkd87b0qeWcLQknKjhprv6UEk6IXZ9CcXJ0TDrOWkuTKDV0BtIb5nU+tHXOXm8Yi7Opka1CKAEq3U2KtBKWfOup7d7oOaG/b6Xj1kR6upmU+6mzm5LMSedoY3XbNvJs8fTv1MY5F4NemEB8SpUtewJw2ikGp7go3iMU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678939; c=relaxed/simple;
	bh=qQoEkT9yk1hood4SLEOpVCocbVX58h+NyrULhtXcu48=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=G3b0D2hIAd+p6B8qWA4PSnummFyTRNZCIdD99v/X06oraQMvFlciiLC67wW2RIvN5XkImwKvQSh2fYeuM1k4GoNzeCteV6A1L+ux5jrWofxwtal7egLmJ5yuilai1f+BgDf6o8xttth5MiL1E+h2Pr1vb+2IUokUhRBPdwl2sjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9dImwKX; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b9a856dc2so12054185e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757678935; x=1758283735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qQoEkT9yk1hood4SLEOpVCocbVX58h+NyrULhtXcu48=;
        b=M9dImwKXgcanwfxZsvF9sIJCNXhB2ttD4g7zrwMDyoS2icglni+By8MUnMRsKhbAI0
         EVO0xNVC4jQP9VBR53a/IUd3z3IYrNXYFkZb244n+39OtNq2r5vOhKcKivgSXlKPMcE0
         LmSYTExXTVrU4OzoRsDAAb09So/r65c9xRJuqzWcvpcF+pioKZs3UEtyWnisfpXGOpME
         vqoWo5Jbcuu867PYwrM23g6YZkXFvqRWw78xWhxXpcYOU2b3/9hlPqIOFOuLg6IzGirC
         c7Zu3bGXmt1iLKQXoZKSVmBHr4aANeEGzzUELjpq41ZJWNjKb0FSRBnOepBzy3pmxnVN
         oaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757678935; x=1758283735;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qQoEkT9yk1hood4SLEOpVCocbVX58h+NyrULhtXcu48=;
        b=m+eFTxIfqTWEFHmipj/LzU3/X4qLF45yWmQMEpyIea1tP+9XwfL6RgS7ydLH49rzJV
         B6vKhXhhMMAb1wQyYKArqScmj7Q+L3tClzZrZEevnh61HM0wWJV0XJavpAZg5kDmh4E5
         vb6NAYue2Y0dd7PCJ4LYFsAkwAmFfZMwLvfVpk7rc/KlhAEt2QNaKkKzK7SyXnFuPWLW
         /uwVF4eG8/WYlcuI33tyRvb3x1dtXI6jdXWpVgDtv+UyQp/AWqBL78QKa/ziPfB93IlZ
         NA4o+XchhYVTMn299I2XVseUIibl9WRei2/ihBDH2WUo48OuF9rbcykt4qK2WP3q/uJ9
         DDWg==
X-Forwarded-Encrypted: i=1; AJvYcCWsDd8mO+pHMeoihlZr0jualmFFD4t687NSepLgQJRM+hC4ttstNWE8KWydISDFg56g1FFbCWWV807lfik=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV4FDLU9Rr2VRX5pNffglXKbiOZd3usVbZ8B0JdKiPDDDvFNFo
	roEf6lJ06DUZ0nHahaHbZYFRvjckODvYWe4jKnVL+BDBU7jM7zNG8a6+5oFYeQ==
X-Gm-Gg: ASbGncuVxvYYJI5Hvw1THx4YkWylfbe/HFIQDTOZyrQh9tshvPdK9wcmI8kyBf7d/4J
	znxQ4I2gteQP/fBSfg7AfueniO7m56nlWU6TewFGedsNYWKtBOfnmRArUCsPK3NNoN+vqQO0+rJ
	o5UC9eVd8ZPPapcVhIIH1aOLVN+WCNoA0tzzbLV1msmT4Pt257qto0CRUuLwJC6SH23aGLmOCfa
	sBkGfzpTgKUbwMWnQGqQgzpB1eGK/NMxGNI7v1tiSZ5arpDxRSYhXesnLCdtXSLJuaeYreBthTa
	dj2Mo70B6gZQh9teUTmq+QnmCjrIKmlKPGbx25CKgtOHeBByCuyzu5a7l3QQiwue6911EubLlDk
	vM2hpuQiREZeFK2n11OCf53buK+vbKcu97Q==
X-Google-Smtp-Source: AGHT+IGdPgp1eBnU7mdjQNbxPC0Ubxkk6H/dLId83PNwbuZGjICOtVkA1L5NSIQ5/V92tkMwWrjUnQ==
X-Received: by 2002:a05:6000:402b:b0:3dc:eb5:503b with SMTP id ffacd0b85a97d-3e765a1607cmr2924754f8f.56.1757678935109;
        Fri, 12 Sep 2025 05:08:55 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:18f9:fa9:c12a:ac60])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd43csm6153099f8f.29.2025.09.12.05.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 05:08:54 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Jacob Keller <jacob.e.keller@intel.com>,
  Sabrina Dubroca <sd@queasysnail.net>,  wireguard@lists.zx2c4.com,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 11/13] tools: ynl: encode indexed-arrays
In-Reply-To: <20250911200508.79341-12-ast@fiberby.net>
Date: Fri, 12 Sep 2025 13:01:21 +0100
Message-ID: <m2segrubfy.fsf@gmail.com>
References: <20250911200508.79341-1-ast@fiberby.net>
	<20250911200508.79341-12-ast@fiberby.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net> writes:

> This patch adds support for encoding indexed-array
> attributes with sub-type nest in pyynl.
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

