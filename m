Return-Path: <linux-kernel+bounces-663530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 549DCAC4986
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 09:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 172EC189052E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 07:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDD1248F5B;
	Tue, 27 May 2025 07:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Im4qVtpx"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975581BEF7E
	for <linux-kernel@vger.kernel.org>; Tue, 27 May 2025 07:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748332012; cv=none; b=eha/CN4mZkhoIl3Oo3wMjikwYZ28pnIz+Ymgi5Yp9B2CFfEpJl7roPGZTmBaDP14xQOgetIu6kTYywyjjKY39pjGTNcOE8xhDvhHDq9oHi0dBYyr+/1ifx9rt62C6a44eYiVZwUPOqEHcioujIzKQ9Wa8kzJNcwKmZzeWvIrhpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748332012; c=relaxed/simple;
	bh=UU7+oRb86zVwx+HEnFQvsgq6dEP8Udyba5tT6b19DPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iff0xoCOhyVitukVinvJqQekKESjsEAxvA/d4UVGJFo4SingYp+whmQa5kOJKWJkT9AqVxT4/ffrmaw2gFbQp2PQaMDxXQc9M7dlRJWxIwQJgejONgliR9zKqnQ7koxxa1iBiF5hCp6cpfTdym9ZvfGGmGjIH4UXd0215YhlW68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Im4qVtpx; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so2700610a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 May 2025 00:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748332009; x=1748936809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kGjUxtNR3mJ/2u7hranrVFwikwHAbHm/cRFgPsL7dCQ=;
        b=Im4qVtpx+F4huEWmY0J0/WOS+oOH04KEMoGTiqfzBvF6fMNs9a/e0yXLwflVeV+tr3
         406rYR0ZGeWtWAtiIqKULbuE6m6CWECUEaIXvExkepk3DaK5015n7vKsmtcug40Zc8ke
         yBulrFiS1XB5zRlgoOZxJqKWfT4NX+En2PUQMgN1bMpdaK4a8gj4rtHUjuaVXNZ3NxlY
         qT28V5k6SRvBGZvcqpraYlHW+m622tvZmyEaNAUcmA9YHFRhIYS1ioi12yTrbAPKaYdt
         UdGo7cSPJ+fXLM5QaqThyxLTQLZfOqZkw4yFMIxUqgskVM2m1tHTpOX+gzjVVX1auloG
         Tz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748332009; x=1748936809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGjUxtNR3mJ/2u7hranrVFwikwHAbHm/cRFgPsL7dCQ=;
        b=iPWo5OhHJ6s3eS+Bnf1UtPfZNPSre1vDhJARVQmuPlpDqXyg4/4jnePZeeQXM7rynl
         t/oho+A0/N/yUSeR0Rgxk6Om/bthlaBylOcfybrwWOTa8QHl7xGskHos4vxbKjSAGdlX
         QjiT8SBAfy8BVWnDoUHrakjJbOaWoawgVxdCRWbk/tKBL76wLLXJvMUnvp4xHmD1geRf
         kb6bEV8CHg0rKcTNt+bjdeqoBBsctBPV9bRv+yoSw1BkXzXRLw7GI0khEhXm9hDIgPt+
         CYpV5dmhdVjNZxslxjmyBl63OUYwX4xP6Bqk8zhcM+jPRs80o3MOxE6lQ5/pNy+WnbMH
         enVw==
X-Forwarded-Encrypted: i=1; AJvYcCXHNXx/bcMqLu2G6DAAO9e+t4I9xlg0ASTuiOsaO6idzOSVUThfWxueKuLh9E2ZVl52xGS38YQKz6LW+tA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1yT5Wrm9CSRU0RSnNzXWkgjj3TSAkV+rN5aD6/LYLjo6F3OSm
	F2b9HXVKQOvHZczn3FVs0EGnYFeGnabpnxChuObD6On66dKcE/IpKiW5GnFCwSJaVIo=
X-Gm-Gg: ASbGnctkTe7RVifP3bXTAYORN4N5O5vfuuT9r2xLKc3DAJLP+upkqjiAi+DSeh/tpzR
	BKHwcQ3Vxz1HLkM7zBP6FWESjkVZJWz2ZZzo4Tifuaf1hdYS68GeUoeTXgcTATfHsVTgkSIdS02
	wm7Fs7gtxfrsFekaG+GjqQcxYnmex9CfqrkulGj+mq5/kTvVlBY7FQJ0FqYCFLNbKR4KHDhicKi
	M+Bb3OlV7fYO3wI7OcNeasP5l9FMYxUkYwbbyZE6T4cxFGtWPAGOFPFENpwRzNxXKE4OPk2+1no
	bHZ4vffDKftRJlRnonN2/0K/64JgLA+uESPauKYjG+fnC/0QDCWViG/Z93ji7olzLc6viQG2Etk
	=
X-Google-Smtp-Source: AGHT+IEWcJvokDvwPgBmEe7nvuQpRK4D3ziJpdJh7OejYmQl2V009fIRSgH2jBGO0ZeLuhaFxXPszA==
X-Received: by 2002:a17:906:dc8a:b0:ad5:1bfd:30d2 with SMTP id a640c23a62f3a-ad85b2795f0mr1165498366b.55.1748332008808;
        Tue, 27 May 2025 00:46:48 -0700 (PDT)
Received: from localhost (hf94.n1.ips.mtn.co.ug. [41.210.143.148])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ad52d437585sm1789776266b.115.2025.05.27.00.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 00:46:48 -0700 (PDT)
Date: Tue, 27 May 2025 10:46:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: Eugenia Emantayev <eugenia@mellanox.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Matan Barak <matanb@mellanox.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] net/mlx4_en: Prevent potential integer overflow
 calculating Hz
Message-ID: <aDVt5LZe-jo7mVxt@stanley.mountain>
References: <aDVS6vGV7N4UnqWS@stanley.mountain>
 <aDVqSjcpG3kvl-0g@b570aef45a5c>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDVqSjcpG3kvl-0g@b570aef45a5c>

On Tue, May 27, 2025 at 07:31:22AM +0000, Subbaraya Sundeep wrote:
> Hi,
> 
> On 2025-05-27 at 05:51:38, Dan Carpenter (dan.carpenter@linaro.org) wrote:
> > The "freq" variable is in terms of MHz and "max_val_cycles" is in terms
> > of Hz.  The fact that "max_val_cycles" is a u64 suggests that support
> > for high frequency is intended but the "freq_khz * 1000" would overflow
> > the u32 type if we went above 4GHz.  Use unsigned long type for the
> > mutliplication to prevent that.
> > 
> > Fixes: 31c128b66e5b ("net/mlx4_en: Choose time-stamping shift value according to HW frequency")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  drivers/net/ethernet/mellanox/mlx4/en_clock.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/mellanox/mlx4/en_clock.c b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
> > index cd754cd76bde..7abd6a7c9ebe 100644
> > --- a/drivers/net/ethernet/mellanox/mlx4/en_clock.c
> > +++ b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
> > @@ -249,7 +249,7 @@ static const struct ptp_clock_info mlx4_en_ptp_clock_info = {
> >  static u32 freq_to_shift(u16 freq)
> >  {
> >  	u32 freq_khz = freq * 1000;
> > -	u64 max_val_cycles = freq_khz * 1000 * MLX4_EN_WRAP_AROUND_SEC;
> > +	u64 max_val_cycles = freq_khz * 1000UL * MLX4_EN_WRAP_AROUND_SEC;
> 
> 1000ULL would be better then.

Yeah, that's true.

regards,
dan carpenter


