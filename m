Return-Path: <linux-kernel+bounces-894305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C5DC49B88
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9955A1889D87
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5160A2EBB87;
	Mon, 10 Nov 2025 23:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fVWPRZl0"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E97E1B0413
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762816693; cv=none; b=QsddItKqqW0T5mynu1JAzJ/YX0MCm68AoyAdTj3tipI3tVrw26KMOn+W1C0hxr2IaKfvTFhxdLBHXi2nRJoPciOYdwKFZfMv3o+fVFAG6fAuxoVISf3LkBSJMpQMUKTQLWXP9U1apOqWD9tFjogkPDTamTupJ2sqlU55M9EF16w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762816693; c=relaxed/simple;
	bh=GXrt3DoXmGxOkDnnai5lG0ysICE5Vy7Q5tTdWDIx50o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UqthHhm9StKoPIghdD1/ZZmMk23lKAElqwRCX45Z2N/zMknAxb9Pibsgf6TqeZQa9NAu45bDh0Y+jWYv6i3tK+PeL1Q7bkLqytBbjTH8GYRqxCyKJ8FUM6pVUpnFrl6GzqqEve5CCvrDzjpkkhzy+R0kdrz0BlbEJMhTAleyG1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fVWPRZl0; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3437ea05540so2029597a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1762816691; x=1763421491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9dxpaS+pG9DKgBRneeU6Do+Nbkb/F4ct4uEaRlcouw=;
        b=fVWPRZl0eIR3/EgKYXkJZVdAykxyINGy3vz9/6Nc9IO5DoQ8pHtdUgY0psiALwLlL1
         o9ljoWcbXI18R5XeLomLEcQCCIwJZF/h6bbPdswjFnQqY7LkGUZEBnhPEVSB+JVPT7xt
         nxNwenrfA865fM5uttI6funX+YmotMYUEcQPCBb2zAcfWtFyy+h3xANkYn494qHw8xr7
         6KhxJtewMEQ/+egCBMomQUrEjSueDEqsNFifvr2sQ2RbgvDC8lzhEDZsmC8hENjA74Cf
         woITLnWCSsGjEZv+GP1z6XB+Mf+smwLZi5fReGUHNSwQGfXgHWws6clrPK/RFNSZFtLK
         cMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762816691; x=1763421491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x9dxpaS+pG9DKgBRneeU6Do+Nbkb/F4ct4uEaRlcouw=;
        b=EITJDOnrJRyg24bir9W/EW807i60d1Fv/HbWJOTayc5N39+O/CsTlZ8pi5cHub3uqW
         Yr22/hiBt+sTQO9zmB2ep9aWmHBmY1KKSTBMRUymmlvPC9jtCnbgzw0pYTV6ae5ubzzV
         gz+tGtur0auQY0IC2tjualtRgz4JCQSVlKxiD727QNgckr5EwF4XZ03rC/DwV2TkVT8B
         NfEmtrHlZtTIK26om+Alu0dS2UA4ZR3bP2E8kReXpt15KSleDdCtZwjOPNu3nq9sueQ+
         Q/OtAtTulYC8fSjifO7akvDWMziZq3Q+VUNnHI7C9gOWlo5XyxIzv63XpYxeDPhx5f5e
         SHzw==
X-Forwarded-Encrypted: i=1; AJvYcCUhNnPlAhoIwVpy8YdquWYb1pDAzzL1BwEMDvLuKGj85tN16VO3qJxg/OXYmiDK35Ys9VECdrwEUtOZSio=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPCQjup7e1SW/4y9aWRb2JlVqt9s6GuBKX+jSgOR0yL2qaDGMK
	CGBLIlzmkuP7XqFchZM89gHFTCNG3IunUuH5cJEbnhJL/niIECl1cc7BWNhzwVLqHwiHI72IV/l
	3xR2w6EmHpjXp+VPOhVRLjtWf2pvsen1wRVavwrrKH1ds2I3wBpPIJg==
X-Gm-Gg: ASbGncvPSQC3K2cRLDk5VEPZRfOCcsxo9VWiTZ602V3xLjDhxYCgnHr9325QHsDWH62
	89dQFnfb20zEgx5DJWNW8azN1n+GMsLYnHfPbDgO34ZGoQroX33BTv3oC3dgGSf+NW59GwB5fBV
	sVBs15pTm2bhaGBgSEawhQr7wEziWl3N8aC7Ej7RLh8klaCgId88H2xaC36aV5gZ5o31UD9GeKI
	s7HI63gWnOvEYE5aaccsq8oHrsYnuCrGhjsQAZ7PTb01fU/8pXqg7qPfElY
X-Google-Smtp-Source: AGHT+IE3y41ANhcAACEEKJqpNkU2rgaAJk0qVLd/UxShgD/TGrSc/ZK/SDru9UmMG7TZ4Cq277UW70rih/JQ3dOB8hc=
X-Received: by 2002:a17:90b:5710:b0:340:a5b2:c30b with SMTP id
 98e67ed59e1d1-3436cb21a6dmr15345674a91.9.1762816691500; Mon, 10 Nov 2025
 15:18:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHtS328bOsw=7u0sN8P0F7Mj2xo6HCQLVkZXMBwp3rqTrAY-eQ@mail.gmail.com>
In-Reply-To: <CAHtS328bOsw=7u0sN8P0F7Mj2xo6HCQLVkZXMBwp3rqTrAY-eQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 10 Nov 2025 18:17:58 -0500
X-Gm-Features: AWmQ_bkL-SHTxE8x0CAC6uh3Kme3nFOr_dVVJyGPshXpwxXJr9FKgI9YSDA9D3A
Message-ID: <CAHC9VhQw2yXuwhVSZERXiOREXzuO7aU=LTUiL1go6v5m5sx3Mg@mail.gmail.com>
Subject: Re: [PATCH] security: Add KUnit tests for rootid_owns_currentns()
To: ryan foster <foster.ryan.r@gmail.com>
Cc: linux-security-module@vger.kernel, linux-kernel@vger.kernel.org, 
	kunit-dev@googlegroups.com, serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 8:13=E2=80=AFPM ryan foster <foster.ryan.r@gmail.com=
> wrote:
>
>    Please review this patch that adds KUnit tests for
>    rootid_owns_currentns() function in security/commoncap.c

Hi Ryan,

In case you haven't already seen this, it would be a good idea to read
the doc below on how to submit patches to the upstream Linux kernel
lists.  For example, sending patches as attachment is frowned upon as
it is difficult to properly review patches that way.

* https://docs.kernel.org/process/submitting-patches.html

If you are having difficulty configuring git to send email, you may
want to look at the "b4" tool, doc link below.  One of its primary
goals is to make it easier for people to post kernel patches for
review.

https://b4.docs.kernel.org/en/latest

Good luck!

--=20
paul-moore.com

