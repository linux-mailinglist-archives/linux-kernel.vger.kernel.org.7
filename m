Return-Path: <linux-kernel+bounces-810235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7D8B51791
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C2D87A79F7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDF22D24B5;
	Wed, 10 Sep 2025 13:07:40 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727832264B2
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757509660; cv=none; b=UzOAAU2JvSHLg5ewzy0OfdVOf9OkacmmlPyrg4sfznjs3MtHN8WZzsuHVrrknMrCUGF50qoyAT7BmeN4YGkPvb3XrV5OXEPc32+1bRpLAaTKbXc4tRfpmiubL3/li8br7HwU5O65wXJuXj2WK5Y48yO+BYbpW2Hou38AOHRjqjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757509660; c=relaxed/simple;
	bh=ywXRFT91ICNiuMZ0jbSsX1fMmPlMp8bNjl1jHSg+6Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkzvSlPVjRZcw/+uAEbmkto3NZcP8FDd4m1sVoIwUUD0QVBa9Ver91S6+2asK0AnqXg5KF2YwTfnpJKjcw6ivbMGCJadWTVWjbsr+eCFK3F0SUMbHACUqCuYql7F5b2vmul/+/EsstUm/P87e63fYYGCswF4OevBpZb2G5W2LmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b0787fc3008so123418066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 06:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757509656; x=1758114456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIcITXX9hS4Db8ikKrpCJbZMjA0TkvI/2W7w/bFCI98=;
        b=EnVHPjJkQhmbTsEmP+VVqxginEdlmPIM62Q27YlXMIrrUWw7yx5qEog8ujuSDoFUUt
         UcoUKTx+xUDuG0LFg78IkFYhi244AGnlcDN5uuGVsWm6H7UmcP7+CQcq0wUes+vAlpJZ
         xu/Kpbuj/jsoeexXztRqux5lZ9jJ1E4Z60q4Lw2fIch7H7t/XIF7j9AOVuwNwNWhN60S
         hmnWNKyRiBuQSDNmVe9eaz6zJ9WaejpHmvMrmCSHLD8eyjQFIiDCGM83DS7frwBdZjf9
         lxI8NgkbbDBfKOj7cbV4wcxJ4ZiuR67E0+uUuJehAFMDuPfy9WU3ZzH4pcGUHlAjf85l
         xwHA==
X-Forwarded-Encrypted: i=1; AJvYcCURq/i9wZAiRt97wAIU9Zvg5VQFiTX2mkFQxXj7RSJ0+kNmNjLCbVp+iYjs0gDzXELhO5XQFNQ7Cy0/ZtI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9WsJm0iiCPljVIehXFEpWZzGPIeYKqAhd6Qs8lSwyWVwY2C0F
	l/vYyB4aSzNjWlxICCjxNGQGyg80SRcsJSkcjUfrVV33vaI8hM5r7IIF
X-Gm-Gg: ASbGncvs5TPgqo1SYjf5RF2UjKKg4p3/opKjit55jQJwqz+vCPFnUen9f568Q7R5194
	hpQ08bo7joxka5HUq14+MpMfKESunZSGf8MimVtBNu1e52NCnOXkrhTYqmIZxPrsiayxgCdiY4T
	Wdcb/llg8j7t32FzzMf92hjnYA8ekdod4FI/QMAPpdk1KUbss2o2jg3MDbK5UCgd0N6MNd3e7l0
	JcVDIwBSpzHxKDq90BRZHpxR/ShYUapJowZOALZv7TR8014gVYAfn0mg/vzpf39k40w9+061viP
	c9bKVLeJMqMZKCbX6TQi+I+gwZfdonii8qZbV9UgiVfZyW2eAVrfgMdt9Hrpp+R4luC887aNy5p
	HlZLOlGYwZ/sGA5kNT39x
X-Google-Smtp-Source: AGHT+IGsbjtxSRoV3JebL//nTu0M1E8u8tcv8+m8aNSPSkocR1/EsvDgvP9SxEsOCJGMx+VMoDP1BQ==
X-Received: by 2002:a17:907:c09:b0:b04:4975:e648 with SMTP id a640c23a62f3a-b04b1547774mr1503623466b.35.1757509656342;
        Wed, 10 Sep 2025 06:07:36 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07830ab325sm164418666b.26.2025.09.10.06.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 06:07:35 -0700 (PDT)
Date: Wed, 10 Sep 2025 06:07:33 -0700
From: Breno Leitao <leitao@debian.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Carlos Llamas <cmllamas@google.com>, Elliot Berman <quic_eberman@quicinc.com>, 
	Stephen Boyd <swboyd@chromium.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] scripts/decode_stacktrace.sh: symbol: avoid trailing
 whitespaces
Message-ID: <2t2c26teepdqq42sx4tbwgithyn63jgy2y23qfv2zy4xff35jf@tesnotcstkzb>
References: <20250908-decode_strace_indent-v1-0-28e5e4758080@kernel.org>
 <20250908-decode_strace_indent-v1-1-28e5e4758080@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908-decode_strace_indent-v1-1-28e5e4758080@kernel.org>

On Mon, Sep 08, 2025 at 05:41:57PM +0200, Matthieu Baerts (NGI0) wrote:
> Lines having a symbol to decode might not always have info after this
> symbol. It means ${info_str} might not be set, but it will always be
> printed after a space, causing trailing whitespaces.
> 
> That's a detail, but when the output is opened with an editor marking
> these trailing whitespaces, that's a bit disturbing. It is easy to
> remove them by printing this variable with a space only if it is set.
> 
> While at it, do the same with ${module} and print everything in one line.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Breno Leitao <leitao@debian.org>

