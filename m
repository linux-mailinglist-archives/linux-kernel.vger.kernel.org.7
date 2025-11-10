Return-Path: <linux-kernel+bounces-893626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DB3C47EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 413594EF3A8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C565C279DB1;
	Mon, 10 Nov 2025 16:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PrxRR4TS"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98AB270ED2
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762791504; cv=none; b=j4rHYiqlLvpWiyf5k631DjvogfoJvdzN732W06gtpSi71nnGLNJar9l4sj6UDUi352Ub4x4wg12WMM7wA6zVRy0gG4r2jRqUkLJs/bZSRdv2dZJNtDAdfnOkUAar27MvXu/W5Qdyk4ui8kLl0PtrobyeHEo3mJ9f9hpTA4IraPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762791504; c=relaxed/simple;
	bh=dS7OqogLeg3C8953HNY4lv0nKlYONxCgkVABniA8Mic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jQpvTJ0494kKq/rSgP4Uv0z3Tou1I80shQUYjIPqN469XBrFU+3PwJ2wb72hRS9xNqlFzL2Ke4IKtatA13TzcOTuczfI0G364FliA0gKCCSCcYjY3Ub2UvNtqL+kUZkWI31FIkKC2Uex1S+V87MFaRTKnBf3u3pdgIv2+/05VV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PrxRR4TS; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b7277324054so468292066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762791500; x=1763396300; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I7WfVMbm69H/BkBks8mAfxA0cFXua4lF5W1Az/5wVzE=;
        b=PrxRR4TSSXmmK/C4uXUWY7BUQlkv20Cjz3b5kLYuTzAyiGmIw1xNa1wtARtAZWTlJW
         wS2r30ZBUljhimL0owj5iT+bhfDQWNEIIH64MR24sKOaoAnPg2aTiAgqI0uyQ2+S31sY
         0mOej26gGqp7U/UOvdpud7jjanKz4lea6Utd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762791500; x=1763396300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7WfVMbm69H/BkBks8mAfxA0cFXua4lF5W1Az/5wVzE=;
        b=hxMoyTyYpGfiNKHVhAYhexUKugXytVnRTC1ykHA4ibVACCIBJd4qNFCiT2VIsG9IoL
         yZInblFlH3x5JnRzTHEKjkXUxOLDi8oUbn73CxsXs5DSvAZo6gl3j1sgD2QZvtegMyY6
         wCrildnqF5kfqFmqEMui5AecGpGhsgo9u1p4tWCStjKQ9X6fvj3cqJrKJ+YCy8gjye21
         Gx4omt9iqc9o26dUjeytJR79sZRlb1w1BnE8hc0jgYA42vacC977rHtcmGz81RL9Nus1
         E3nxCFbm/wHC3JY8I9AKj7Zu38OGAb86fLT860gppEl1yCyxctLxsdkCHmcxKBxCEYg0
         p9yw==
X-Forwarded-Encrypted: i=1; AJvYcCVsFA1a6iJrWTrJpsOOY25zEZ2TMW6dzNVnITBzfggceMsvzp5pSEAprHAWnDIvyrCsOXmLBqBtpBLucDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhULVgZMITFqUF01NlCRWRCiPhbN//8oDAkWKcCMw8srlHj1KQ
	Fb7dC0Vf/8N1oBKz94pfhfiqCoc/vHTqHXuVRQGblTfO4frUHe368RbSnWO/7K4vBByuNw7vnRW
	wYgZIY2Q=
X-Gm-Gg: ASbGnctdwICi5Yej9MREEnkjIwU6CY50MrN2muk/HxUAeAxP1s8M5cTfZKI5qT2UYB2
	jS5izZC8qaf4O4AlodR6TRiFspsA853sW5VZm/cy/TGokJv0Gf0UPuwQR8ZOmenixJRj2JGI8ks
	LnDaBYDiVYxslrYyCdU2/AR0kY+ZGlFSsc7ECo4kCRcl/KaL52FbZ+NxO80CDv3EluFFshQ9HvU
	qTP4JRDXDv5cgJSfytYPx9XwfoowpISu+HFelJOvB3xyYezYycjgLLgQRFeklmwxgnHAKsdbrCr
	sl7g1Cz3iemYemrC/IkPdPYizfptX32CH7BDED/hZMA+mi07OlqLOvAbOqgLTo3gRQD5H3DXQkw
	l0GL4qT2Xft8Ol6DhuhhujCXz5NufUHdCFNuQdG71/g1U5XS3De1NJWm+GS50P45fCA+1rVkMxD
	eR5z6D4hFSHdAphuC7Hlcwo+xyKRCYXlGUL1tvmjpQjP07sYL1
X-Google-Smtp-Source: AGHT+IHTMa0n8rihJpCuCER9bDxgA24FFFl6JoMVyOFhipCfMYvh7fWn9SvT+kMaf+O63xNRN3iZSw==
X-Received: by 2002:a17:907:869f:b0:b40:6e13:1a7f with SMTP id a640c23a62f3a-b72e0377907mr876335966b.27.1762791499825;
        Mon, 10 Nov 2025 08:18:19 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf60ef8asm1113550966b.30.2025.11.10.08.18.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 08:18:18 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so545569866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:18:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXsZbXiGF5pu62HBdV9UCsZ6TCXuCdhiSZoW++T7wcpbUzPSNQcYjLv9pBs1V+roE6XKO726nPB+HijpAc=@vger.kernel.org
X-Received: by 2002:a17:907:9602:b0:b3f:ccac:af47 with SMTP id
 a640c23a62f3a-b72e052d65fmr915819866b.31.1762791497952; Mon, 10 Nov 2025
 08:18:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110114633.202485143@infradead.org>
In-Reply-To: <20251110114633.202485143@infradead.org>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Mon, 10 Nov 2025 08:18:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj4gDw2iMi-OSbCov3SVDJCQr=YCRr3JZr9Mz-eNwfmGw@mail.gmail.com>
X-Gm-Features: AWmQ_bmARzYOgS1WW049Z184O2gMmwEXIwIZEtBJV3aaaV-R3k3i0YlbmdI3i38
Message-ID: <CAHk-=wj4gDw2iMi-OSbCov3SVDJCQr=YCRr3JZr9Mz-eNwfmGw@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] x86: WARN() hackery
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, kees@kernel.org, 
	acarmina@redhat.com, jpoimboe@kernel.org, mark.rutland@arm.com, 
	maciej.wieczor-retman@intel.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Nov 2025 at 03:58, Peter Zijlstra <peterz@infradead.org> wrote:
>
> We should probably just merge these, as they improve the code-gen for WARN()
> significantly on x86

Yes..  And I'd actually like to see some example code generation in
the commit messages just to make that "improve the code-gen" more
explicit.

I know I saw some originally (or at least we discussed it), but it's
been long enough that my bird-brain has long since forgotten..

It looks like this series is on top of the BUGVERBOSE_DETAILED updates
(that I like but don't have in my tree yet - I think it's all
scheduled for 6.19). So I just scanned the patches visually and they
all look fine, I was just left wanting a more concrete "look, we used
to do this, now we generate _this_ instead".

                Linus

