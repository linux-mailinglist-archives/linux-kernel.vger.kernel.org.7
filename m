Return-Path: <linux-kernel+bounces-770199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E892B27861
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9308962280B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1788F2236F7;
	Fri, 15 Aug 2025 05:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xtuuhoFu"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFAE1E32D7
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 05:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755235401; cv=none; b=vF7ESvWiEK50/xW/DNoC+XNWpAiLwt04i/CI9sOyaIJEERKUbEi36+7P/k0kmwkXXwjQPgfal/eQ+pTM/g0968w1Az6XmlRkv6YXqNQwX6RZYSnpF1ihnipn4DQ7cf5HkIbR9lFBtY3duw0G51OXJui7+mGEjiDWyZCgFntCqTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755235401; c=relaxed/simple;
	bh=V8Ueiz1xSXHXEvy644YzyjPt8VCpS+xcVARVvP0U8mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huXILgwiuwQHqszHZNQ+5ZAAKQXv9lyDw3ZK51l+H8V6uKVVxlqDDmB38VFACwMnxa6PkuXkz6408Vuy/EqecbrhJaGAzcV/JuLSYTfiDGOJnWuxgbD+ZHNMC83wLGn0MZDTTRPOgR4L0jylZFkGroUKFfqKzrht1X3eEn2j2W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xtuuhoFu; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a1abf5466so9224495e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 22:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755235398; x=1755840198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aLn6FEN7TpsXc1h2u3bLPPOQktvvlCLchBVsgnE1xvM=;
        b=xtuuhoFuSK0LVpxWBSNYcavSVu3GYNnd74SrfkD2wQjKhlAsrHl+pVUSbaCdBgtNDr
         YKfdKFrzGBw2wmODl/ibp+ilud4hPWrTdrB49mpoQVxwo8mbgyMVFzIf46PvM19KvUsk
         hhDWVFIv6HhHc+6V3F9S/XdGoz2dhOl9hzbuMLPQZhzbvUKeqRoADnAgDWzLImTGvex+
         7zkoMfeCu5gbb2XUaylN3HAHGv3dRkHEguRf3ChLw0HsHKh10eS81OSD8MyX6yjl/Qpz
         1m5OJ6Bp0idmKRfQtzV6rwlHJ+KjR3xltHghPt4Wdu1YgHAj57jkCqzoK/0YVHLl8y7n
         9Liw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755235398; x=1755840198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLn6FEN7TpsXc1h2u3bLPPOQktvvlCLchBVsgnE1xvM=;
        b=mwNpWth6md/daW4HEszhdtrYeUBc7HuwO/+LbHkfhkkcAgtU1UvonhGrzLIqantpzZ
         oh5W7KOnOaWre1WlEIIaz8fUJtoPIMFRnCQlxQWv3gwiDWpSKndhO6i+2mUKi/sK0Rv9
         Jz6iXh6v8yHJkCCOd25ggSciykazeLD2XW0AJwFWcAyvayLtsi1qpVsM076E7TdPWFCo
         pFUperHvPdn0HxxQ5OI/Dfj0JtOqGqwlVoVpsj5jT+LMi/soWla2Zmj8ko87HBdgxG0O
         rFNb2mARVwcufskhonKi4c1rpxtxxSThii3d5fj53PW5t1oYfKWVTWsp1jDdO717rv6m
         IHJw==
X-Forwarded-Encrypted: i=1; AJvYcCUwkkGMsgOZPHHEZ45F1vKphHbK8gkoMq6I7PzN3yJWF1HojqiR+RMlrjkJZWIeB2n2bAoI6jxwgqU4hVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9oqsbfMdECC5BiffJE33l+qt9p6W1h2CD3Vpo+D+gEhvXwHF5
	cqXpsuqAGWJ1EEu2jk34Im88vEAOGyygrLBf4j54yrv+8G/+FmqWXDIgenIcG3muVrY=
X-Gm-Gg: ASbGncuNAzRCdYg3eMF5tU08AYzrLIt21eLKIRXQdHMytQX8sWsSsmvwj7+50HVptZ1
	i1nAyv1epUqcDUEFSY9RPWV04fzP4NJZEtCxAcq5oMcqqEcEa10X2D0Oqo9lr1XRW9AP1xk6rei
	P3fAYJv+q4nbfNdnt6GXanG9EhupUeXicPzHEyE+GWQWHh9RH2m65P/Pd6vZ81mtbRaLuIFL1tL
	EdrRfeeFof3RuNszTz7/AdH8EHHP7hagA+X5LMNX3PYCF+HN44ubEghMz7SoOvXckXtjRX4jajA
	5OEviSYe17gi4Q+atEvNfsvJN6bOrpdGjp2/UVmyC0plxBu3GSgkQoS8iSqei2gwuqS8e7myD3O
	EB/vSQ7I/5CjBm+Cn7+XN0TPObJxGLzwm+qCjwKzpb6oMs7ALjJOmiQ==
X-Google-Smtp-Source: AGHT+IGFNhJOx/G+JoNt5kMjzVx46v4txqtKecbS9qJlHx4GlX6Evp2HRHELTQibK/pD8aO0fgDabg==
X-Received: by 2002:a05:600c:6095:b0:458:6f13:aa4a with SMTP id 5b1f17b1804b1-45a1b66e4b5mr46968775e9.6.1755235398079;
        Thu, 14 Aug 2025 22:23:18 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3bb5d089e07sm678141f8f.0.2025.08.14.22.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:23:17 -0700 (PDT)
Date: Fri, 15 Aug 2025 08:23:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Kalle Valo <kvalo@kernel.org>,
	Aditya Kumar Singh <quic_adisi@quicinc.com>,
	Rameshkumar Sundaram <quic_ramess@quicinc.com>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Bert Karwatzki <spasswolf@web.de>, Jeff Chen <jeff.chen_1@nxp.con>,
	Thomas Gleixner <tglx@linutronix.de>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"John W. Linville" <linville@tuxdriver.com>,
	Cathy Luo <cluo@marvell.com>, Xinmin Hu <huxm@marvell.com>,
	Avinash Patil <patila@marvell.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] wifi: mwifiex: Initialize the chan_stats array to zero
Message-ID: <aJ7EQZFT4rx2Tnj_@stanley.mountain>
References: <20250815023055.477719-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815023055.477719-1-rongqianfeng@vivo.com>

On Fri, Aug 15, 2025 at 10:30:50AM +0800, Qianfeng Rong wrote:
> The adapter->chan_stats[] array is initialized in
> mwifiex_init_channel_scan_gap() with vmalloc(), which doesn't zero out
> memory.  The array is filled in mwifiex_update_chan_statistics()
> and then the user can query the data in mwifiex_cfg80211_dump_survey().
> 
> There are two potential issues here.  What if the user calls
> mwifiex_cfg80211_dump_survey() before the data has been filled in.
> Also the mwifiex_update_chan_statistics() function doesn't necessarily
> initialize the whole array.  Since the array was not initialized at
> the start that could result in an information leak.
> 
> Also this array is pretty small.  It's a maximum of 900 bytes so it's
> more appropriate to use kcalloc() instead vmalloc().
> 
> Cc: stable@vger.kernel.org
> Fixes: bf35443314ac ("mwifiex: channel statistics support for mwifiex")
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---

Thanks so much!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


