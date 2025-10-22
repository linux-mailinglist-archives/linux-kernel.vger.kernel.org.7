Return-Path: <linux-kernel+bounces-865846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EA1BFE2A1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BB9D3A7E25
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50FB2FB973;
	Wed, 22 Oct 2025 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6GhyydI"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21EA2FB633
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 20:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761164783; cv=none; b=QXp1NOd3lne3/Y4KBbKkDjz74fPI8SJjS4gMuWcMjwG44ZTYYG8rbS+dpduwBvzknCPd2q1EW6hh/gkwW5jnC7uQzNU6LcIU+j901BCiwejVD1dlyrTa2JPcxsdHhM99cTFk+28aHipBaGUL5hIrZQY05VKvj0NpP0rZfDb5og0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761164783; c=relaxed/simple;
	bh=DN8wIHw8L2THEi4S5dHy5jflBlp+QDhGYC86piH+GyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qh8bb6ib4YIoD1K3ckaDvspjX4kcEPRRdC9joGfntbErEVsfZjH1UUFoF1ugUURHWVEFL0oVCoQ5g8EI7gFAWG+9V+TIHQ6EqR3ZjYNHbM2CRqWQd58NkctDgWL9GWYWlnubQRl4dGs5L6wKXtDYl11+v/PXEU6Bh16ABu6RoQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6GhyydI; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7930132f59aso85878b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761164781; x=1761769581; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8hAf3HpEiT48jV3m4EHRH16LKqqSsX+cW74wRjoqq3Y=;
        b=a6GhyydI27nchsOK3XzmQMxvgdrwjht6IYms4fXsm5Rou6wqUAUou3UxDDgWVcaMTe
         c8YHY+MXac52rT/giDlKOghlIXA2zHL6i7ydzQbQEjUxxk1jfp8W33CraOyQFwT73FPT
         y60oFTrbwMiHz/QtNW53RFxCNoJMhmhGvA8AZmKgqLIkgqxi5iW69oPqrTe94O0dIYmX
         RfGGg1fktM9XdWzVZiFnizEAbLvCyh7oHWRwotMdf5OvK2WydGKvIGc/OKI4oslXlSox
         Dui1yspkwGXPLNN1xpzz7Lg/e1oNO5NMmM5CkSkF/gSQpnzDnYvW7bmm1mv7ek+rHKFs
         S2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761164781; x=1761769581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hAf3HpEiT48jV3m4EHRH16LKqqSsX+cW74wRjoqq3Y=;
        b=p2zs+bh3xQutqSBZcU+yzurR1LgUOjGnffW+gZ8o2KVJYfDeNBKV/PzDCvFz6aRV/k
         FUnxKYWBwYgz1DsiLAsf/WcIC0Gyo8pycPz1pEKGMuvCO7APwqQq0aGp6mBB/ujb6s6r
         adztuhe555TKN/w//cx2N342NeVCXUvsN7SvwNlROzsrH0lGQI01g/w28PHFVYIZybiF
         1Wh+Qmj7Js17KwlZgZMFtUZi25m6MS5+8036MnTSK3mVRHl4ZyvEECU2XUz9d7rK3SFW
         wuVGE+Phc8CQEhdrUn71/IGBQcdbZQnXnY5QjXie7JAAqKGvEjiT6o9spG8ULHYq6T+J
         29vA==
X-Forwarded-Encrypted: i=1; AJvYcCUYuC7K7cx5hDRiaFSELKJ1jhmmVbn+DpZiEDlMjmu6/TyNxzqAjtWw6LoMdo7UeoZmoHgHK5UHyCWWePg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1SprS1bzAWXa2P/aSM1XUErv99zUObswnAMY8ifG2kVbEsd7I
	6ubSpesnQ8l+IELRenZlVv8HVKocsQ+kA45ICzCzZK6kst48eF1X31N+
X-Gm-Gg: ASbGnctT+PUSNswkvYAfGG4sjfd5amnHvF0nx9HcN3BQAB98WpnB0ea43k9xHzo2kFh
	88w0IPrvwkLnb6RLDKGpCTFSiAdhlyqGIGWWiEiI3UCHNfgeX+CpMptx6hSYe+f9QEFMxzShwF9
	HMZd8qZqNsVACw3vHp5onZrII+iSZ9XTdAmPrlLhfXFWJT+dD4itRcflTXRrdKDgaK8AKMtCuEl
	PgLAfIVY7ClxfRzvxlqJOo0jvkuCJAGSFqCwWXmc1b6AF49sqSJLtpnn7UACc34kF4t9kXG/lQj
	tNDayXDzCYtkJEyNX/Aw9eGnYWhI9YtUwa9waubUK/Lca+STb63CieZIYF5JcbefVoWT8ZgwYTg
	e6dDNJOWFINQWTIYGnnIB70x5Xfzqr4NQ37U5L7WCDFa/X5To+8aEyk729Fk4gjTHz0qcv2tnA0
	DYkUOD51J9a3j/PTfYwClMK37rmnAkNs0GRZIABcc=
X-Google-Smtp-Source: AGHT+IEUWrw1/NIF6k2oNyNi5aIySqQPjcH563349gLGnf1V8S0/R+EqsrCwP+l1wUXaJawvs0BBZQ==
X-Received: by 2002:a05:6a20:72a0:b0:300:5f0:a4bc with SMTP id adf61e73a8af0-334a85bb055mr31514224637.45.1761164780878;
        Wed, 22 Oct 2025 13:26:20 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:53a9:459c:bdc:6273])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274bb37dbsm101523b3a.57.2025.10.22.13.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 13:26:20 -0700 (PDT)
Date: Wed, 22 Oct 2025 13:26:18 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Job Noorman <job@noorman.info>, 
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v4 2/2] dt-bindings: touchscreen: consolidate simple
 touch controller to trivial-touch.yaml
Message-ID: <vv3bpf4t2fgj2iz3hbevw3u33phqitfd2x7mk3ow6iqrjownbs@gab34yb6o2ee>
References: <20251021201924.2881098-1-Frank.Li@nxp.com>
 <20251021201924.2881098-2-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021201924.2881098-2-Frank.Li@nxp.com>

On Tue, Oct 21, 2025 at 04:19:18PM -0400, Frank Li wrote:
> Move azoteq,iqs5xx.yaml, himax,hx83112b.yaml, hynitron,cstxxx.yaml,
> ilitek_ts_i2c.yaml, semtech,sx8654.yaml, ar1021.txt to trivial-touch.yaml
> to consolidate simple touch yaml binding to one file.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thank you.

-- 
Dmitry

