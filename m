Return-Path: <linux-kernel+bounces-859019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65155BEC7DD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 06:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 025CE1AA51EC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 04:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0115B15ECD7;
	Sat, 18 Oct 2025 04:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLZVWjEV"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E044224B01
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 04:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760763035; cv=none; b=eK87eL9ENfKJB5Ykqy7KQCKj/lhtQ8qysyf+YKkFQ5X3ylPyorH7N9A46xs+Yp3A7epl9c19h3gLdsRTAA+2juhWuo6aR52yUoPsmg59KZQ+flu9GtJdoBCuovxLxNwDYeVoYhGPyJoaIkvme/DhvWbZRZBVD2b95yT0DH6p2IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760763035; c=relaxed/simple;
	bh=k4F1HHaAuhImo4Rj3lkcJWOnbRZXj2OebT2TeychcTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y72+wBvIWksFC9ndTbVmue/ALXnyNLidW+X0qIx4VQ3ipcWMdDoQltrPg65X+NZrcXVMQi3g2nF05lAUPI0PgV2/LiYSSYVm3HjqYEOP80jZ1Pe8CHV2pj3SebuBNYmMiPCWg9qwtJ3j87+Wb3l504/yfqFIEb1VSpAHPV/FJsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLZVWjEV; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b62ed9c3e79so1775611a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 21:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760763033; x=1761367833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K0sMcbjnxJjL/lB/sP+Eamk3VovoERZKocwwc1E/DhY=;
        b=gLZVWjEVInaFy/fHqejlqgq35+i3eIK6Zkya/wIYtLtEhNP8S51glb/dAFwyi0uh2k
         oSDCK4A38QLGWJ4i/A53s3oZWHUt+eu6A3m9TguYTNUIlb4/5scdV0/TAcY6C48ZKnGD
         WDYMYEp8WQ2hNt2X4fg/fuvVH+/4ldgLppsSEYpAKz/vNnAZAlP5kq7mjg+TOuR5qr9Z
         FDrQv1pgnQ5/uFoCUfrvWVKpNoNHZhaxBUEAba7zX29/2pGH2IPkA7bkXo/WmKjHp+Km
         ia6/VfIsQqeI2Zx0gqwe/ZUGQqZk95ves9/wHU9MCZ5b1t3slIJ5dFpCLFaz4FMEs4Ri
         mxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760763033; x=1761367833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0sMcbjnxJjL/lB/sP+Eamk3VovoERZKocwwc1E/DhY=;
        b=ByraENb2sZnjHjfUyCFoFhQetSWTJmGdu1gMILI6vEAuAouqgbA37MUwWp8VuJsOUO
         JnaSA0+ohTwpdWPc3O7zTPwgGNs3s1E3kMm9ZtjNnQwK6XuHHh1GtYFTeQa+QtvMtxCs
         BzaBWZoz1rAMb6AoHZDaz+QBC/vIN7vfdntolm5Cktpbih+194lCLM6n8deWAyNpoQqB
         4l7+cJPqy2qAAESOEsWtYIrly4Ltwl7K55AhijaN3v7/yHtEW6H0LDZlXzn2G1lgjgve
         fK28vO3BNGtB0ejuhb9x9PXuUeEHMwc8pE75xpj1reUl6Q1HZSPP0wtymED7eyZhJIx0
         SVYg==
X-Forwarded-Encrypted: i=1; AJvYcCWN8JckEt7S142gJcCINMorgrMm1F6NYJ0SBkKiY3HwBYRQwIsLaMViEx4rIrQXnq2C42inIiou/aN0Tis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz55kEbcXx4wru0V3QCA9FpHD98QoIYbtNyVzXUYzeJasQtGanM
	eyM0tELhtcecz0LZE5JvNNMVGVStNTJ9XdqvPDz14rXNEMlDbAiLN7hj
X-Gm-Gg: ASbGncvcT4+pQ0TX6J/frGbWqL0V2q9YRrnk8moHKeFFNBUzOccl/s5C2QcmRPdM4xA
	Fjtqwd1TLlmp/SuvJbHLydN2R5/fz6GY6W9jupol0e3Ahu9iPoTtCUgFz32Fp1/SN+5K3oGX0v7
	ipt3393ZcFMYywa87DtXmwmBx4TNXSiXOn6/KQfiHuh2oVe4RQ2hqd2my2EhAo1MBFIH5jBW+Hi
	8V/qXt2ey0q0bp7WW+0ybiv/R1iBCum6wH//NvRdjRO2qbE9iT0TivMvPl3yEtVBXJCA0WxH4hK
	dk9y2xA2omuw9RR5UCcn1wZ8sGBJEycY/ZkYn1SUL1353Jq3A7QBUIEO7Mh8pLi+ONjN/qywFHe
	Oeh2/x4unO4B9ykb2ia08Lc6yToyU3vUx23hYwKKZpLyH2M/mskLTNWWYoqrLSx7QaZNXry6Ydf
	Y9UsKSmbWamgn/6o8n4vtZWf6+jLngxPGgiHYSqAst
X-Google-Smtp-Source: AGHT+IHMjoy3JYX0GIA0YqODQYkO7XpyCQFTI62FYZAFiPaOqOChaluABKwmRhz9RmejVfOVQ4yQKA==
X-Received: by 2002:a17:902:cf0b:b0:269:4759:904b with SMTP id d9443c01a7336-290ccacf11dmr76359905ad.58.1760763033380;
        Fri, 17 Oct 2025 21:50:33 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:5e2d:c6df:afce:809b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebcf06sm12900515ad.24.2025.10.17.21.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 21:50:32 -0700 (PDT)
Date: Fri, 17 Oct 2025 21:50:30 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	peter.ujfalusi@gmail.com, devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v4] input: dt-bindings: ti,twl4030-keypad: convert to DT
 schema
Message-ID: <6v45x6qq5onrmpjtfuyow4sokbchek6nul75neqvj6jhu7sf7j@a3qbgsl72ncy>
References: <20250819222823.157943-1-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819222823.157943-1-jihed.chaibi.dev@gmail.com>

On Wed, Aug 20, 2025 at 12:28:23AM +0200, Jihed Chaibi wrote:
> Convert the legacy TXT binding for the TWL4030 keypad module
> to the modern YAML DT schema format. This adds formal validation
> and improves documentation by inheriting from the matrix-keymap schema.
> 
> Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
> 

Applied, thank you.

-- 
Dmitry

