Return-Path: <linux-kernel+bounces-863478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3943BF7ED8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BB494E3D38
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8E834B696;
	Tue, 21 Oct 2025 17:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QdEAuSp9"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FA33557E4
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761068270; cv=none; b=b2JrIfxM0f5L4rDweNq6hea4u4c6e1eWIhtoAHLSHbc3o7UUWACSFnMO3EPiovuLQgMpHyk7M1/rwKfJe7pQVMM0gH9R3LESDMJtQETlpdhCgRKxpxLCTl+QOx2hMge2U4s6dUyS9AE4oc58uc9B/eqIAqmQOwdeTcUsUVpegRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761068270; c=relaxed/simple;
	bh=w9lLASQAb3MzFOmkR8MUQwtJkigXHJHfhdRGIS8U5uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IN45JnJoDXOY3sve/elG625w5KTpQzn3clZH6MhqIVZ3uZZJWTXaJs8kHcOakptqatmdfOrn+LVjuSpaYGYgdDYNBfYE3Chk25WhWvIsUIzChXhP8bwpPIQAg6Vwn4dZQTr5mZdknElWueJ7xroa5DE0hBhjT7yXImDYclICxf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=QdEAuSp9; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b4aed12cea3so987869466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761068267; x=1761673067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HzP3NHmpVePzzX4Nk37cJRY8V/e1399mO4lbkZpYbsI=;
        b=QdEAuSp9mwNOauWEJjrVkBlYiNhSp1d1NiNBJ03d01QB/RYhivsFSTp2UiirXuLKP6
         OeH9DmWYra8t7ggDTwpO35SRgKRwCjDIqAoOUCCLJbGWMiN78sjWdhGkEWmYsAZood7n
         /dWoN3roVOiQHAOKSvt3usiLYviGWCZJ76UhlyjiKd7af6mtJgrTApO8R0kQRU083xZM
         8KeOFEGjBatcLY6Ktd161H4hbVWY/5/d7P2afTBNIFxgFiZZpJPvjFpf/6lDHB3BGlkl
         A9Ayorwct/i586EDWC5axIJcZNZBoJSVt0yCJKQD5ylOnbP+lbIMCrf7PEporrIlt8kE
         Dx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761068267; x=1761673067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzP3NHmpVePzzX4Nk37cJRY8V/e1399mO4lbkZpYbsI=;
        b=fupD1YVv+6i9U1RcWBc5LFpYZzK+2sVr6JRXUNSb2O/TcGh67a2VA2b6riV2UOyKuo
         WyShLy1OMNpLlF70i2FLFtBTlRRPlinpwWF5S1Dl4zTyIeimjw50pgdeZZhJaglnEwVp
         ICRyUd8Ac0NpKZqg9+gjShl22LsmqxuxwjpVciBmUsxD1sRYXcCuI8SDGDvTNHbI6+U/
         SAN0pYaNuZeehGvfPxUkZv8Zu9mYJBy03K2cZQNtTJ82qbpFjjyHxfUSlOeSVSgO/csJ
         4Zfm5GDgbLSTB5dCTAqC5GjklFuOQ8mDBpLlTy0BTqrCFqXEcWnS9BV0qAfRi982Yn2L
         XbWw==
X-Forwarded-Encrypted: i=1; AJvYcCWjJGvYeI3abqfSOaYBxxfe0RQTgAgCbKiaL6WYaCdhXuxDgcXOIP8VgSZu+HCNAy7YHoQda/jcA10oOB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/h7RAtzcYT3OxroI498S+37vCBQ1Pjf+tw92igFFU7sdugIwj
	eSmRqZw8yx//8MZ71C0e+VorqdL3ZsYJnxAzr5Lja2YJMupMzKLtclmU
X-Gm-Gg: ASbGncuRFomU5j5Jzzw4/QHM9v6ARHlhJyIBLG+RDqAFJ8yPDDKoFLCPi9LgwvptbLw
	eZmt1l7WMx4uphHV33/FXz28eCOwVVVzhwbO9chaxTklf/3ZUFdpXad/pFUnd63GpGSmfuT5SOl
	XFlzlj4EeIFP7gu0ZRTuVQ0dK75Ky2xKqwYVVaHCmKrxKUX/6wRB9oeDN3N+Pg19PbJLAIK+33X
	YYbLAR/Jnvjdg6fcNvGEhJfabXpXQV3shuOdLn8f5dz0vfUiDu33v5TvpTaMflKmF2PMQWv0It0
	DOqb535/RpUMiwuVxAHrTuaQGmp9Q6gORkmfEGrbpz6SLpBIA0TitBfmQoe5ukFUDmaTilmIoNV
	ybx/sVIpF8K1MlPv9vSjdEnw6Y599ovrZzb1+H0o+VM4P/ljG+cMiFbiagTDhSVn4UbbLGT4h4c
	PCNZ1D3iQ=
X-Google-Smtp-Source: AGHT+IE3bWO5VTrkecU9jvIu327KrROeLdwSscMAWS5uaEu1sOxAkVe3ftuURMlxB+jwqRZpHVyG5A==
X-Received: by 2002:a17:906:7316:b0:b54:981c:4072 with SMTP id a640c23a62f3a-b6472d5e88cmr1997955166b.11.1761068266270;
        Tue, 21 Oct 2025 10:37:46 -0700 (PDT)
Received: from hp-kozhuh ([2a01:5a8:304:48d5::100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e8971897sm1122485866b.37.2025.10.21.10.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 10:37:45 -0700 (PDT)
Sender: Zahari Doychev <zahari.doychev@googlemail.com>
Date: Tue, 21 Oct 2025 20:36:38 +0300
From: Zahari Doychev <zahari.doychev@linux.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: donald.hunter@gmail.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, jacob.e.keller@intel.com, ast@fiberby.net, 
	matttbe@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	johannes@sipsolutions.net
Subject: Re: [PATCH 2/4] tools: ynl: zero-initialize struct ynl_sock memory
Message-ID: <7mgcwqzafkqheqmbvkdx6bfeugfkuqrgik6ipdoxy3rtvinkqq@uxwnz7243zec>
References: <20251018151737.365485-1-zahari.doychev@linux.com>
 <20251018151737.365485-3-zahari.doychev@linux.com>
 <20251020161639.7b1734c6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020161639.7b1734c6@kernel.org>

On Mon, Oct 20, 2025 at 04:16:39PM -0700, Jakub Kicinski wrote:
> On Sat, 18 Oct 2025 17:17:35 +0200 Zahari Doychev wrote:
> > The memory belonging to tx_buf and rx_buf in ynl_sock is not
> > initialized after allocation. This commit ensures the entire
> > allocated memory is set to zero.
> > 
> > When asan is enabled, uninitialized bytes may contain poison values.
> > This can cause failures e.g. when doing ynl_attr_put_str then poisoned
> > bytes appear after the null terminator. As a result, tc filter addition
> > may fail.
> 
> We add strings with the null-terminating char, AFAICT.
> Do you mean that the poison value appears in the padding?
> 

Yes, correct. The function nla_strcmp(...) does not match in this case as
the poison value appears in the padding after the null byte.

> > Signed-off-by: Zahari Doychev <zahari.doychev@linux.com>
> > ---
> >  tools/net/ynl/lib/ynl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
> > index 2bcd781111d7..16a4815d6a49 100644
> > --- a/tools/net/ynl/lib/ynl.c
> > +++ b/tools/net/ynl/lib/ynl.c
> > @@ -744,7 +744,7 @@ ynl_sock_create(const struct ynl_family *yf, struct ynl_error *yse)
> >  	ys = malloc(sizeof(*ys) + 2 * YNL_SOCKET_BUFFER_SIZE);
> >  	if (!ys)
> >  		return NULL;
> > -	memset(ys, 0, sizeof(*ys));
> > +	memset(ys, 0, sizeof(*ys) + 2 * YNL_SOCKET_BUFFER_SIZE);
> 
> This is just clearing the buffer initially, it can be used for multiple
> requests. This change is no good as is.

I see. Should then the ynl_attr_put_str be changed to zero the padding
bytes or it is better to make sure the buffers are cleared for each
request?

Thanks

