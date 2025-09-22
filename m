Return-Path: <linux-kernel+bounces-827956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D83CB9385A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 00:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83F7219C0B50
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9007127FD4F;
	Mon, 22 Sep 2025 22:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ISu5aJij"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ECE175D53
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 22:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758581492; cv=none; b=F2S6HRBwcgBV45hm1wNR0EFUNOeVOh1kdMbAvDw2vP38p/8RzCs58kp+XcLxZDC3frVDsAlQAkyTj5Jix8A6KJUXWyXLKYsZedYNDo+B2YLS8DpNJAKpZmYgNysWcCsfsOG9H1k7ckyzj9Lgqgpn6hWLXB7qhr1r7oXfPlOVX0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758581492; c=relaxed/simple;
	bh=2g8jlSV13FfZ6qkhuqv9628GiY9q1dcdi6cGOpwivkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m9l6O1eTaE3/L3s31QvgWpLVVYwpJs7lJGqw84NuxkZPJNmA1rLWednkfKXYOZDQrelkOsWUIVQ5jaKZVDhl+fCzrk8z+cgUHfLNvp6sBWTevfYmLEaEU8Ps43/EVIV95XJFWMkSn6Y8xUK3Q2z2XLFwrTb2Yf+v8sZFnaVub+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=google.com; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ISu5aJij; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b78657a35aso192031cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758581488; x=1759186288; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rsFqUYLoEXoD5J7mOVBIukerFwBJh/oFQEJX3GcFNXs=;
        b=ISu5aJijxQd/gRp4zpvPRDLffWmLbD+naeEQHBr7kNM+XEun7bxbeTWrEUmWmFk4qS
         b75dL8Roxrh8Qy4JGeCmNocMMU/iwYFxCliWnx+mmYot/CeouahsHZH1PzIz8T/MnY3I
         SMvKgT0hr4cSvHY5vYG9syqWNQhnBy9hnl7Tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758581488; x=1759186288;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rsFqUYLoEXoD5J7mOVBIukerFwBJh/oFQEJX3GcFNXs=;
        b=vApHN54rB2RRKvXKP/ZVrcPHCAV9qMT419f8mFtK8QzbpOVhY+h88j41nvf+VcWXx9
         v/1qThpDMHS8zP0zIFw63V+PUSWW+nLoGWvUuz62aJlL4db3CHwdpRQm6LgrD8mjkIlQ
         pNVY8MLl4Fp1qaelT6LBvPYrA23WtMDWrqJlzRYFA4xl5fOgfMZRAMPhzFQHBn9AWHOy
         ZpK5t4isuP8e2Lg5w3koL0OtRqgb5ubwNEWGorhbiFzSRpDyumkh/pnZMNkjPZMicRA6
         UnshMyOguE2qlXGQ7Lf5KKvjU8cFlCXKUBED4JBphWZWN58+zJq1KACvZam6TL3zfh+D
         e52w==
X-Forwarded-Encrypted: i=1; AJvYcCWcTHzYvBvo7GxDIdjw4A5X8o74KxPxgGVNNEtubSL+f15tA2PLvka9UwctFjyr42d8qJldN5k+K9Tqqi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHQNP3uKQgJuTZkdZR04+k/Gl68EWvLLbi5ugLAHaPL25JR1kh
	sHS5eQpFBPzrjadAuA72M9tJBmXNRKszIiXNq820XLuXo/Mn0H1b8jLR1qI88CS3aHi6koOOUJB
	ghg9W10jLULN1WKFI3dViZCGuSUSZqlqdj0W8sRJ1
X-Gm-Gg: ASbGncty7VtMi2G6QrMuDk0iOAneUp+uvPtBdqdZfelFJtLYs36tL0DSibjigVsnxVS
	r7iuIXazZ3y7vVSHfTI2GAL20HZjfNWT0v2Ixpqy0hut/zfjuR/SIQLXdiN7UBhGbmv+kr28LrY
	A1YZqm/hT1YQu6r/cP+jPr5/HarPWxCjBxJv2Z2CW/74CDhDk75TVuZsNPXnSwdutNVq0VSMHxN
	CvY
X-Google-Smtp-Source: AGHT+IG18k04i6yd+3w9+a4LF8r3bj/68nzAYS3FJRGyOwOiHFPA+oaENwNeQlDYdFKOGHnIPYNxxRKsOoNLzUX4L7k=
X-Received: by 2002:ac8:5f89:0:b0:4b7:9b06:ca9f with SMTP id
 d75a77b69052e-4d34fd300e7mr1230171cf.2.1758581487970; Mon, 22 Sep 2025
 15:51:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922-b4-ddr-bindings-v7-0-b3dd20e54db6@gmail.com> <20250922-b4-ddr-bindings-v7-2-b3dd20e54db6@gmail.com>
In-Reply-To: <20250922-b4-ddr-bindings-v7-2-b3dd20e54db6@gmail.com>
From: Julius Werner <jwerner@chromium.org>
Date: Mon, 22 Sep 2025 15:51:15 -0700
X-Gm-Features: AS18NWBZljaWhB_nmi4xcbYeOCnxdVtC_xiK4EoqJwWbbbZzXiw46pHjGIXlGuI
Message-ID: <CAODwPW9Js2AjSzQrvRFMK3xHXjbb6qV2bGEj3GhYWpDELniyCQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/7] dt-bindings: memory: introduce DDR4
To: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Julius Werner <jwerner@chromium.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, 
	=?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Content-Type: text/plain; charset="UTF-8"

> +      - pattern: "^ddr4-[0-9a-f]{4},[a-z]{1,10},[0-9a-f]{2}$"

I don't really understand why there can only be up to 10 characters in
the module part number. I also don't understand why you wrote "20
bytes (10 chars)" for this in the previous patch. Are you assuming
that module part numbers are UTF16LE? According to my reading of the
spec, it sounds like they're supposed to be plain ASCII, i.e. 20 bytes
should be able to contain up to 20 chars.

