Return-Path: <linux-kernel+bounces-775462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E21B2BF6F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F7D6830AB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79ED6322DAE;
	Tue, 19 Aug 2025 10:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="BJTLR2EL"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE02E31194F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600889; cv=none; b=O4GAXAZP0vp4zg4iDBLLgKdYXkUfo0nkvbRfN27ekQe6pLm1iuhsg28wbnDOvos390PUugd3fgugtmFWvTNPk2ifVnKA9lSlpxZsrudG8PBorK6tODZyIMG3YdBzuils/2vTj7LG3LNdSxDHYGP/Z4ZwN9x/ZqqdhLRnMrRy++g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600889; c=relaxed/simple;
	bh=6yCHoVaGq+4SdzPbm/a2+uFQTdad0EyYgYe4cmXoxlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMd25uKMazJMT9PlkXdF7oNsXeySdFJs+ubPiukdcjhh5VJ5WU0Ws6yua6YSX5X93K+hMLSbIjUejYQAiPldHj3HuPle5tzM7wyi6/zdQye2y4I0y/LurjC5MLZE2DZXaU3jcnkK1QtqvORq4Hk89JEicm4kEV0U7X0bw869tew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=BJTLR2EL; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b109bd3f9fso65021841cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755600887; x=1756205687; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6yCHoVaGq+4SdzPbm/a2+uFQTdad0EyYgYe4cmXoxlk=;
        b=BJTLR2ELRf/MVqCh8zo9iCGS9EpbeFMvrQ7m5X9MYOR74eO28dfLq6t7bTo7QbqzRX
         TJYDhzYAIGCgbz1NajUidQ6VUQ4EGxs/hO73BVyU602gprEOKhj+bMLElDIrParUF+0h
         IfEsnTxTfYkfzg3yalcY74m42Ef0kwLH+oczY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755600887; x=1756205687;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6yCHoVaGq+4SdzPbm/a2+uFQTdad0EyYgYe4cmXoxlk=;
        b=jDVChm0i0tdEdu9rSaAXIvm9/mOuk/OuJ6II5ySEIbQlSE6OhsvPCNptjric4Gjyu3
         l/4cRVj38R6JibZzLjap0XyOP9AiAF03d+Z4EhMCZ9Y8uJhuvtX4VuwZePmXx+uDh8Cg
         N431o/gRyoTgXgVJ3yqCeGZdZxXPtLE8c25cHZIHc4NhpYgdecaxZdpeItaSm9NCU/cf
         s/RzY9PotATx50XEEj61OSfXWWxVnXdtALf9jjG+OGkxl7WEu+ypjljAJwMlv4ZMX+UY
         wvWZZTlTYlGSTob3PXfCioh3ULtnjnqGr0txyz3H6H0wTJMlsEMdwH6sC+abrOk64T/a
         sSsA==
X-Forwarded-Encrypted: i=1; AJvYcCW52RE6Xru1JM7V7Hu9O0ZvhDmCSqdHIcz5ITZNdVt4V/+GeoXPP3S/FuT2deGQ7A7hQvIx3xYQ40HDS64=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvVmphfMeNwHsCQQbcJ9yHOjb8dtg4XuC/7HqB1VUk0FkzbvTi
	dCJpXm+zHuCiW3vA76Bku+9mq6+1qd8UjY5o7bxDqCeQJvCgAsC3wDdgP5Vl1Uf5pUp4870bwaZ
	pbg2QcKecY1dx2cAcP2iSlS08LB4Pdeeg/iKQpxNn9A==
X-Gm-Gg: ASbGncvRqfbE+veQYg2EXS+o6Pv96S5H7yDVDMDO/qGEHV7HZ4C8lPAGWqlERD1Q7Ak
	+RycM78dg3L8zNnRccEqfyVTGlmnDNsXZ1SnPO3zJHD/5paWw+U9tI+iY1mgMFXMseFTJ5J+7ye
	jUYmPhgYyy0S/Z1/5gWUd+33UuO2jveu6KHFrqBcLL7cOnsT9ToRdroAq8CtQYzolteuReVzkpx
	0w3VAaQ4w==
X-Google-Smtp-Source: AGHT+IGoA0MFmlo2xnMlSxpzDsHBCn43Y/FZNExD/OWKDz6VX3pZm1Ai94Gc4ty5kd2FKGmS9chdojXJrkCtR7ErajI=
X-Received: by 2002:a05:622a:4e07:b0:4ab:80e0:955f with SMTP id
 d75a77b69052e-4b286d1c17emr22020411cf.34.1755600886672; Tue, 19 Aug 2025
 03:54:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730130604.4374-1-luochunsheng@ustc.edu>
In-Reply-To: <20250730130604.4374-1-luochunsheng@ustc.edu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 19 Aug 2025 12:54:34 +0200
X-Gm-Features: Ac12FXzTUa6B2gqZdV53Nbqmh2rOu1I6mJta-4Jhozqr_obCpMz3u73DhKy8jF0
Message-ID: <CAJfpeguVSwfgR+O2AwpTof-k3g57ZCkS0mfGLGYT23ocSqDNig@mail.gmail.com>
Subject: Re: [PATCH] fuse: remove unused 'inode' parameter in fuse_passthrough_open
To: Chunsheng Luo <luochunsheng@ustc.edu>
Cc: mszeredi@redhat.com, amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Jul 2025 at 15:06, Chunsheng Luo <luochunsheng@ustc.edu> wrote:
>
> The 'inode' parameter in fuse_passthrough_open() is never referenced
> in the function implementation.
>
> Signed-off-by: Chunsheng Luo <luochunsheng@ustc.edu>

Applied, thanks.

Miklos

