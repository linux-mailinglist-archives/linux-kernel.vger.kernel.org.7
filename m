Return-Path: <linux-kernel+bounces-820651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB23B7D3EA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 936C07A51D8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885DE31A817;
	Wed, 17 Sep 2025 12:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g2nZdA2K"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED89A31A7ED
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111502; cv=none; b=JTWHRUJLpntA3h0+ZGMsspPBj/PPqr3GT+RLYmg7d+AUUKTn4GY9Lzpm4mCkUicLxlfv/7FmOvphbnPYQUTu2K9mB1zjmR22C9r4IsqxB2orzXFtve6fAAmmHb/xAhwCpgW0YrFrXdKnZexhSZev0M+x7794Al7Zi6FvukDxJ9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111502; c=relaxed/simple;
	bh=4wF0NswZE7UN7ZK89Q9LWSerbdB4GRUzQoxODxqN8/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfxtxGlofvuuoZWqojfVrBsTVMfmEXdaOWHsQhN8scFFGu1GbnUg9Y+XQSABU1/cJVpwv1FUiRBplGkM92R7B9dOaLMEzdeyTa7rTf/hSID7bso/BSDMHJzyrx5gebJmmBLX4eHWVc22/AanKlyCyxcWKK+mzU6+aV2pBRl3vcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=g2nZdA2K; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb78ead12so949612266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 05:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758111498; x=1758716298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pg7+WJItHMFq8LpEQ/3CowoGij+u8xuGzyGGUP6FSZo=;
        b=g2nZdA2KfLHHMDTzilBCDqrQiZXQiDW3J39ivQD7OJqQQ4mcbqHicty6y3YJ2nBW8I
         Y69BHJNJ2STohJo1x3RvL39cQKdrX+g2cQyfiwAjZP0YNl31aX0COhjF5og3XrSqfmKK
         dwcbPP9helFOzX307ClZvwqW0D9BohJxVrb+qtZJTG1JPPM3IJ8JFny6NKEiEUREAWW/
         cHPXxg41+q1cJDJnDc+ZUMkM8CPI/CdMIRmFtYY/vfeliAHA9n7maryZxCG4m/6iWWdz
         WF8FnqPiP07suzpRryjFIxU0G44QkOXk4P+7MqRVlIs1wENRWpUY8alrY/77uHnq3tVT
         30SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758111498; x=1758716298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pg7+WJItHMFq8LpEQ/3CowoGij+u8xuGzyGGUP6FSZo=;
        b=Mk4aS7JKltMq91YWurU4w0CTKXc5XGSjwfKWWh57VxZQ+Mclua2nWlWH4izgJxCCIR
         kdAg4hBqqEnoabiTXOP/deUOgdgvrLF/Dtcb/V1Zfhc/7an4uNlykVBYP+Fw+gTZT0yq
         gJ7wc+hA/Dko+kBFr5ZbQRAC8cUJsmXr35606dckLK1607Rxg0mkrmbhJmKJpj/ijglU
         6/7dmCuvcpyNEJGO8qhZoDmJj1v2eJ7mEdHwpOySSt8ofaauHKhAiqRmK5GOmtIYhwx7
         LDGwFnty7cJlMLMphthSuv4fq0/uuwdYrel2Trefi2enhL9zyurGGC5B5wm+gkblaxu+
         +9Ew==
X-Forwarded-Encrypted: i=1; AJvYcCVAFKYil0gA53vUiaGOi2x+01J9ZMSq3tAT9iuostN2STsur4FCWqrkquQE5z1/a9SpHGOjtXfc6q6/62g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCFRRQiVrNQvLUqst+9XBhtoG/IAmy9NPy7RwFhbkKfqa/KkIv
	/qriRBGUdY5xojUVUVReUsW8g1naRyO0d5cHpsAEkSKdnKv+gcroEiy5GFpeh0oXIJIyoPglb2M
	4+vxCKHk=
X-Gm-Gg: ASbGncv3FWVoS+MaE//kts6rN0McH1OCwZdGEvK3vTU3To767In3Xgns5jVdfwJL+LI
	tSIlxSimcqBlGHh4xIn1XepCMxjKvpTa+v8Odw91/OWzF63ffGR9d/VBLcvR0Hbr2JkMNVo4Oat
	tSpwwiTIoiYHhia0mxwYu0QrtpvA+NAInePKNKjNZ1auL/RVeeyguRCgiND3oYF9DDUHDAJb6+h
	K4gBzPyb9XZn87krPyekwuxAMU9PIvQPkT98ydeb8pLyTOIlbFRkHWSQlgjbSZVWG8RFo1PyTHN
	qh97+nKfuMgbAQvuSVVpmhmlHzsC3vh4wLA5rEVddCU/dlcedqIb0fefYDGYUvyoxz6r/RflCnU
	ERThcWFTJFKfnd0pTE+Yc6+887A==
X-Google-Smtp-Source: AGHT+IEb7tp1h15r3X0LhpR/A/w7KsUQunpdhfzrvEkMQYm2/zv1mPCjuFensy+wsfkrSrm28kM+qg==
X-Received: by 2002:a17:907:3fa9:b0:b04:8496:64f3 with SMTP id a640c23a62f3a-b1bb9268143mr230352666b.44.1758111498037;
        Wed, 17 Sep 2025 05:18:18 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f482a3153sm5463195a12.0.2025.09.17.05.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 05:18:17 -0700 (PDT)
Date: Wed, 17 Sep 2025 14:18:15 +0200
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v4 4/5] printk: nbcon: Export nbcon_write_context_set_buf
Message-ID: <aMqnB8d3A8-NBdo-@pathway.suse.cz>
References: <20250915-nbcon-kgdboc-v4-0-e2b6753bb566@suse.com>
 <20250915-nbcon-kgdboc-v4-4-e2b6753bb566@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915-nbcon-kgdboc-v4-4-e2b6753bb566@suse.com>

On Mon 2025-09-15 08:20:33, Marcos Paulo de Souza wrote:
> This function will be used in the next patch to allow a driver to set
> both the message and message length of a nbcon_write_context. This is
> necessary because the function also initializes the ->unsafe_takeover
> struct member. By using this helper we ensure that the struct is
> initialized correctly.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

