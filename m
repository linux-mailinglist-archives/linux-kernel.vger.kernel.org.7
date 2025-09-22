Return-Path: <linux-kernel+bounces-827789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA87BB92ED5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6542F19071CE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661EB2F28FA;
	Mon, 22 Sep 2025 19:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0K6bGSz"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8762F1FE3
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758569925; cv=none; b=s1nX7beVARUSMlM+Ma2FKOUfsyj5RoQCtLxAWe2ia3U+4u7eHZ3GdBkhqyD7lS/63XRvuqn8O8Zuhafx/UDHTlQu2fQVu0IWEw5iRqxPd9HoWUOZecJF0RRzyNhWmAHN8NnIin8HRouIGYXIu51ktWUSnB/NVqSd8Pb7khllTvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758569925; c=relaxed/simple;
	bh=zSkwFxdawuhzp1rpRWhOyjFp/r0ht9I8B+KlJS0Nahs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iEfmvw+bL9IVU9l9TgI5aQLLEmoUERTqQlQRAieeIAagGis+gmGhrxSmfDSa2Bm8G6T4r7KldOiPRdE9556NooJTSJcKwc6+551hcjz9Vw6G4W7qA/8HAWw840EwEUN8V6Xu2iVTDqBIpxoPLM11nu506nhxfLti5sWcRq48U0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0K6bGSz; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4d16cd01907so7436531cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 12:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758569923; x=1759174723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxb0la0Xz6K3HZRfHiufAhiCg3Bf0VK65WFpq6/jGV4=;
        b=l0K6bGSzTc3nbH1O0AL6rwTQSsUMT/Dvo5kV7IEhsqsOoQudmxEE3mHII2VUFvclp3
         B/Z3I4QpqjqWiMLT6fzchI1PyHAH/fPh+gRlYLMzCA7p7qpE5P/pzgP8Yc6Qt8QKgf5K
         3rOkyOvdEgcDizj0vu6JsJcRxzUaMxJ5wuouuBgY5salm2R30EDL7Aalb7rr8BaCdwCv
         94wztORklPAqnfi+3IbCQ9f9Bb+LxD1OjRFrX5/Mxaf/Rw+T3QDlKWgOMOzIwWJ/c6Bp
         i9y8CuE59/lVW78uKG2ojxlqX9o2iN+TwCsczY16ovIUxH9Ip9n1D33OzMtRWe9JoxAz
         ClAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758569923; x=1759174723;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fxb0la0Xz6K3HZRfHiufAhiCg3Bf0VK65WFpq6/jGV4=;
        b=fn/1tcg2PQhq2MC6tGX12poQ6dmosDEwdS4N/0LrdUqb7upkcQFzt6FYJFurSpgi/g
         PsrFYDzhuZoXBTs8aARTHaeU80sPYwtfFhwA8SQGilZ25hC65Lo2DXFlCBnwGR2kfhRb
         SrUjHtYwj2St/73RdcqpKZeETVv6sKG6jiWqNEwuSKCkwXLK3iy2iJhtawe2rx7JTnSh
         vscgg86xUMmkXb5ocGCnDGTinxrB0Cbs6qtZYtay2zsjE/dQKYo9hCkPXhQ+Zcdt246H
         7xm9+yoW2x8y9lQLsYcZz+P+AGRryD1XjIQlpigSqgiTw14XhP+dG0cd4ol/KnYKdGYG
         Hnlg==
X-Forwarded-Encrypted: i=1; AJvYcCWGC9cAFiXu5rtgBP9O1FLA52K0sPE8V1IN1cTsBAGLMu9FEazc6e3QTBJiZYmLXACnfF2IfH6SsFC22T4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzERb3hMSyPdMYwM4TvOGcmTguKfw1nRdVlbqK2362HX1TE7tFz
	tk9nhKPBjFUOca9QqTB9vY5G4KumuazmlejoWUTsKwAwVMwhfyYZANXO
X-Gm-Gg: ASbGncudwOJC5zZBhlcBXMWOzyVcP5mMZhrJzFSV5XTyMZnCpuwCvnMIGV5Tvyn77eH
	VKNgoPd70sHo04rYqWG0KMj+vlaFMhPMq0it96Uq65AxwG0qqMjLThUTlghvJZY+6ybSInzMJJf
	LQMOev+fU8m2E1d1D1Ts9M+DQ2zh0ps5K2BlOH29pxrxuvM6OHfmp/9QkdZtxN1LK6lIe4oP6IO
	dgOjTvTicHecSNbbUIIKWBy9hcmuqOlcE0vuaqgSGFyruT1lIwiKBPPgGqoJq7/p7CXaHB06rfr
	zRINFSigMZdvYiTh+H50FBzVd6X1lKurH3mm5BnVcv+J2yb2I65Dh44Nimd0i7tSAUGDOcBS9O1
	pjWKcy1brGykaWb78WRr4hdRlZ9KDBPgcPpccmo2paioNcD1UV8oNGBjeBtUMeUrSXaMfBQ==
X-Google-Smtp-Source: AGHT+IHERlRcxB2cgVPJSZcI9+IMM5lYOVHfSDwqHjbWSaC8Fz6GFhkMqV35fhCj4HyUwgpMTDhivw==
X-Received: by 2002:a05:622a:1650:b0:4b3:10f0:15b8 with SMTP id d75a77b69052e-4c076040eaamr170655631cf.77.1758569922833;
        Mon, 22 Sep 2025 12:38:42 -0700 (PDT)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4bda15f91a0sm75500011cf.1.2025.09.22.12.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 12:38:42 -0700 (PDT)
Date: Mon, 22 Sep 2025 15:38:42 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 ecree.xilinx@gmail.com, 
 willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 horms@kernel.org, 
 corbet@lwn.net, 
 saeedm@nvidia.com, 
 tariqt@nvidia.com, 
 mbloch@nvidia.com, 
 leon@kernel.org, 
 dsahern@kernel.org, 
 ncardwell@google.com, 
 kuniyu@google.com, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 aleksander.lobakin@intel.com, 
 florian.fainelli@broadcom.com, 
 alexander.duyck@gmail.com, 
 linux-kernel@vger.kernel.org, 
 linux-net-drivers@amd.com, 
 Richard Gobert <richardbgobert@gmail.com>
Message-ID: <willemdebruijn.kernel.416ce098eb01@gmail.com>
In-Reply-To: <20250922084103.4764-3-richardbgobert@gmail.com>
References: <20250922084103.4764-1-richardbgobert@gmail.com>
 <20250922084103.4764-3-richardbgobert@gmail.com>
Subject: Re: [PATCH net-next v7 2/5] net: gro: only merge packets with
 incrementing or fixed outer ids
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> Only merge encapsulated packets if their outer IDs are either
> incrementing or fixed, just like for inner IDs and IDs of non-encapsulated
> packets.
> 
> Add another ip_fixedid bit for a total of two bits: one for outer IDs (and
> for unencapsulated packets) and one for inner IDs.
> 
> This commit preserves the current behavior of GSO where only the IDs of the
> inner-most headers are restored correctly.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

