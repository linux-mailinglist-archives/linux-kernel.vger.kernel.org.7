Return-Path: <linux-kernel+bounces-884894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5E7C316E2
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B836B4E5A5B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1E332C33B;
	Tue,  4 Nov 2025 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ba/ZCEpE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHhaG2wB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF8532B9B4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265447; cv=none; b=mKkL2jkd+oJJqpU7PHXhHqCPC3Th4DT2/b66iV3QW7btwDmDxs7N7AcNXeXCkSxz7okXbJfzWqjAuF/aZ2XZ10LVdP7VxJhaD5hOPrvtHZJeYbcNC7mgknMGz9/wvYf/l67XiX1/kWmO2BpjZrF2QZ5EJB6l49cOu2Znm9QZ/uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265447; c=relaxed/simple;
	bh=kOQJzZDZyFM5wXYEgd/w8vVqM/Mg2pMo5lBxbRB6cEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OtWJC1f6uTkq4wWc3O+QwJqBb4ld6ZJ5WuRHG5wWTEW9bDVSUUcc70oSGVfjO9Edpm0oB24mvYPdrLIlFsMgreBltUhiOkIssEBNtUN7JFFTjLYbPkJJukSRijBOBNOPPeSdln5MVvmlJ5hsM3zu9bKEsWlyUi+TahTxOpoluas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ba/ZCEpE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CHhaG2wB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762265445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kOQJzZDZyFM5wXYEgd/w8vVqM/Mg2pMo5lBxbRB6cEQ=;
	b=ba/ZCEpEypHh1u1jZLLB3kIHlvOGMQcidB3ciuUilKcFALjUUJvLomhogbuO+F6hoyjCgG
	ncLa2AiiTXnB5bomJH8RUriwciXSS9IE1r1MVnXSb3+zF8V3t2O7bKShunbFXekLMzkA7v
	AA3427MMvQ2kZHBB0/NR/6uqPDo0sbY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-eH-c7naRNUmcT1NuYpltlg-1; Tue, 04 Nov 2025 09:10:43 -0500
X-MC-Unique: eH-c7naRNUmcT1NuYpltlg-1
X-Mimecast-MFC-AGG-ID: eH-c7naRNUmcT1NuYpltlg_1762265442
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-591ead2ba5fso3837289e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 06:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762265442; x=1762870242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOQJzZDZyFM5wXYEgd/w8vVqM/Mg2pMo5lBxbRB6cEQ=;
        b=CHhaG2wBxdHf4kIVaSTXnyEy8ecuajD9N/vcTH0vzw5/19OioXZsq8/G0eCNungxfQ
         J8mDcl7e8hU8b5QAFOi1GaXOb2ufI7JNavGbmOMy/D/ZPOoog5m5E0p3qhoTVnjKIvGs
         xbs0U1WUXt60yPVzav9slTlJNCoQxI6I1dz7DrFQUgsE1uUjfReO4vTQE+EBNBeutB11
         bI4mkg2fxVcs6ktzJUKiGwCjA/ouRWfCuTm4GGcn8+LazjvaIZt1buz3rqtwu2PjPqla
         andPG3oULxxXcqZ6RsRaYjqhHusctJyoQ3WCLcendbD4fyKqrehdyl8CXvbG+d/vtXEZ
         VumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762265442; x=1762870242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kOQJzZDZyFM5wXYEgd/w8vVqM/Mg2pMo5lBxbRB6cEQ=;
        b=xIyVzD0oucxKoMnFON5B3vsIqUi2WD/O6D3lvm7yWtqdICMe7BE3ccYb1iP4Y/b2ep
         Eg69qStMHIi95vH3tgaxhFghSPZ8eORWgshcRfuGDzr8K6r4Gk3wKSVJwFqVLkyNlqsS
         y0V8qDW9N53asTezu6O6tA++CAO6xNLH5TLxDDTlkdG/kQ4QQ+iwkz9r3IZXB99Vw2Mq
         P4ELeJOsueriPfNYqpo3nuUZrlGQ+93xLOEhIVO31sil3aPGlZfZVl6SrZTidQUAh8iI
         N6jF6fd8IZgF/dqgEQT2CfH+PiIaiI2kqd1tyg6hmeA5+C+DML5SKnMgOxzhAvB7eP1F
         H5+A==
X-Gm-Message-State: AOJu0YwC/0W2wVnrkiSHN2X7IJn2SFYRAUMkxFqWp2aRkZDjuG7YR+Ek
	EfMrUZuKe0m8AGj0vKEJDQZpyN4e/HlPc7IWSbwhIBHl8NBOMhrbfQxDSGNM2vOlZ7YKy00dTTC
	yB2hNDkc9B8Yb4pGFqjGCI+0GetpugI407azA13t2FRD9+1tmptlWMyBIfW+WuNN5RcqTOTOHSb
	aX8rO5nf7xZwZajhbYJ4ho2umdpGcZ5YNThlPvPi5B
X-Gm-Gg: ASbGncv5eyZWgaA4Dtmz4gOVodEo30V2fM8Eea4XHVEYV1bD7T0t64+IqUqVhynYFf3
	DHKGYg/1bXy9hJvbcvGGEaISQat9pQmcV0osMj9tDwb1EE7wkSI6AYU6RbVkjk/6A6Ov+WK5fH4
	Tr3tiGPc6CVA82UVBPONu2SzUUGkF7+5dCccxoz8twx+LDvaR25dt3mX9j
X-Received: by 2002:a05:6512:3c92:b0:592:f521:2334 with SMTP id 2adb3069b0e04-5941d4eedeemr5207469e87.8.1762265442045;
        Tue, 04 Nov 2025 06:10:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzd+AgX+SxHX8XNy+La2tKTXleZsFzvFKS92bHfkJwYH86llClCOpV77Ngrt3fnpXownJ+KIcUGAdGx6MLF6Y=
X-Received: by 2002:a05:6512:3c92:b0:592:f521:2334 with SMTP id
 2adb3069b0e04-5941d4eedeemr5207456e87.8.1762265441570; Tue, 04 Nov 2025
 06:10:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALTww29GVOw3sk2=A_9dj5QMGtfogRjxRsunc1D74AqLFj_MyA@mail.gmail.com>
 <20251104093449.1795371-1-hehuiwen@kylinos.cn>
In-Reply-To: <20251104093449.1795371-1-hehuiwen@kylinos.cn>
From: Xiao Ni <xni@redhat.com>
Date: Tue, 4 Nov 2025 22:10:28 +0800
X-Gm-Features: AWmQ_blglH4aG1yLsUXdEGUiksyid_PC2Ymu6c71UlD9PofH0MnqLRl0YVyins0
Message-ID: <CALTww2-f=tUM=3PD564gNNfTs=4dPGH5mhmY1c90DZ0kT0PnwQ@mail.gmail.com>
Subject: Re: [PATCH] md/raid5: remove redundant __GFP_NOWARN
To: Huiwen He <hehuiwen@kylinos.cn>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, 
	yukuai3@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 5:35=E2=80=AFPM Huiwen He <hehuiwen@kylinos.cn> wrot=
e:
>
> Hi Xiao Ni,
>
> Thank you for your review and feedback.
>
> The reason for removing `__GFP_NOWARN` in `r5l_init_log()` is that
> it is already implied by `GFP_NOWAIT`. However, I noticed that
> `__GFP_NOWARN` is used independently in `raid5.c`, so removing it
> there maybe incorrect.
>
> Best regards,
> Huiwen He
>

I c, thanks for pointing that out.

Regards
Xiao


