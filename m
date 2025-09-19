Return-Path: <linux-kernel+bounces-823872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1676B879E4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC3DE1B275BA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8CD23D7DC;
	Fri, 19 Sep 2025 01:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORDUABLg"
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379CA23026B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758245857; cv=none; b=FMRkMZdF6J4+lAB8V5srXEuLbwuqu9q1OeT6RQ7Bso/llE8Pnm6CVCEiJ1ZimT4mETvG3QfxJyVjBXp89KPMtfR1qKHdnT/LNa6ipwYcEvz2qNWdVopVwsIQ6YNidOp+SSxueofQMttkTLql9Np1wV/Nq1HH+tO03HQ8npA0zCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758245857; c=relaxed/simple;
	bh=oh+YAQYzkzp/kESuO+e6+GbX8Z05sYTm/l6W84It+LY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VzHmfgNT+CK8XuoqoEC43ovHIwGUE/4+fDwJfw5u2stEpMcTFv8XofeZJ91mwLufczfJB5T0DsnJJcs7qbgls1uGIN+P8lfVaKumtx+Z2zDznRQNP3UX+0Ufy4fDmJ/roP9oNFO1ZIsY4aPwZLG5xNzeFStys7Ai1nCfiiZwAIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORDUABLg; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-5679dbcf9d8so1542784e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 18:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758245854; x=1758850654; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oh+YAQYzkzp/kESuO+e6+GbX8Z05sYTm/l6W84It+LY=;
        b=ORDUABLgjgwdrMy3wJEtdlh+jAJpIS4xK2DlintDaOsICYd4mh8Lrw44u0c9jWBNpB
         2FioAGnpbvQ0bewPIahdtRplkSw+5TXDyUgfTKQP4H4CNXrCUQX76FCXMERzAno5KI1f
         OxoHLPmsuPCEQfsncKox449QC5QbYyrmnubpQcjkIbf1GtkCu3fDa8qd+FDT+oIiXZ3K
         s+Hueh3F8tb459N0Jqfh/9Ee0SXfBWQRWGCsn/L1Gg7IcNjebmBpVVZjKvkFnsZKv0UG
         wa920HXs+cX4mYq/tWmNriUt4hh32SfBuP/BZbCEZPLw2X+4QOg/NASpG7934U5okvQh
         yo2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758245854; x=1758850654;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oh+YAQYzkzp/kESuO+e6+GbX8Z05sYTm/l6W84It+LY=;
        b=JgYI8JzAyUPY3axbtpbcWj45+B277qgInR70xFJuefiffk0+K4SdPDl2Xd/aKcXTFk
         2mZrZcp8HRnmRfWFbYVLvGs8AZdvFcQVvyeFq11UWEnuNAFaLE1NBobbehEKRJwCiL2R
         /S8snDQ+lwSGmxE+TioaiXuML1C2gapjl8t1EPCxC9yATXroZaL6ukPgYGb7XyZ4QETQ
         5/kLYoePap2Spl9wjWQeB7anrLbaKkzeoVhEJxg/eqHpWGIi7n/VccVpdUfeq9c/gDHb
         iV4tD4nxU9GzaNWz7OyNXzahEQ7EGBWgLulhmqVDZwc6oYn/ofkhmJoNBHQamrMnnupQ
         PuLw==
X-Gm-Message-State: AOJu0Yz8vDFXR4FAI+EnbtPQYO6devep1YJRW3SANnq7TEPgdzCg5hSS
	LAUIruHrgJ8vl73G6KeXZ0dUa3GkB+HpUVFuuiHGYn0Av41bXUQ3PaN1hcYZ/Gz20JxGtC7WXp7
	Yb6odPI665c46NDXpiCTIe28AI/OKUeY=
X-Gm-Gg: ASbGncsVo9e+N3HPIJnbaH9QW8PzQZ8N+lcHr7Wvv/PGdrHLNCz/bzb02daAodziGJm
	34CdMbGsB659IuTlnknScx/mX9g3IqAKOJxNsnfPwBeY4TTFt0mU0JIKKTkAIZnwh5DH21GCGga
	8ezYx6ms/SJCBcbd9CQaOQuWgNVcn4laAKA/5/0wt2BfiyrpGDVXXrnxWFnINqbgaVWLl1uFviF
	7jaLdpt
X-Google-Smtp-Source: AGHT+IE6YFcr1LXSicjMAvNHyV5cFPci7myF+1gN+wiyrMKw2tnFFRjv0o/sCqJW+GIukZMFxzfzqtm3teaJ8ye573w=
X-Received: by 2002:a05:6512:134e:b0:572:1f0b:5ee2 with SMTP id
 2adb3069b0e04-579e25fe471mr533873e87.43.1758245853928; Thu, 18 Sep 2025
 18:37:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910084316.356169-1-hupu.gm@gmail.com> <CAKfTPtCyL=ofg4yLtfG7zsoBMDnP48KCeUELT_Hddd3gnWeYEw@mail.gmail.com>
 <CADHxFxTkexicChcg3To4=AsX8c+s2RNWZ5NfA9UBLMfYRZtmKg@mail.gmail.com> <CADHxFxTp3sMAwsJvwJfPQ+aD2p2Jk34wAvJGSzQjK+EypO43tQ@mail.gmail.com>
In-Reply-To: <CADHxFxTp3sMAwsJvwJfPQ+aD2p2Jk34wAvJGSzQjK+EypO43tQ@mail.gmail.com>
From: hupu <hupu.gm@gmail.com>
Date: Fri, 19 Sep 2025 09:37:22 +0800
X-Gm-Features: AS18NWC6TmGGVONfsJh6N0ktuCcCxlk6cNIVDtR9lBnsy4gpIAkLMrhOjm8QQ1Q
Message-ID: <CADHxFxSFqok5NrtV=NkmJ0O5KnUiDn6=OUYYumWmOgVmvK_6NA@mail.gmail.com>
Subject: Re: [RESEND][RFC] sched: Introduce removed.load_sum for precise load propagation
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com, bsegall@google.com, 
	rostedt@goodmis.org, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, mgorman@suse.de, vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Resending for your review and discussion.

Thanks.

