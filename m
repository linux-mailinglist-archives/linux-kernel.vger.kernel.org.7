Return-Path: <linux-kernel+bounces-847178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACAFBCA2D3
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 18:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67D261889410
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 16:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E37F22422E;
	Thu,  9 Oct 2025 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCnG8vPR"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4486C202976
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760027037; cv=none; b=DGnmpwHte40hefr8LMgnb0kv4cZDq3jaUDAASV0WzJknCBOhrCKFK45aqn2S8RPzR2R4JnTRjVArH0oAZ4O5Pkug6u4u8MAA/BqDNXbg5DX39189aj7ncSB2Xa9itEOqo9OmWQpJvceMvpD8dlXT8itwxnYG1OOr11ByVs5zLfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760027037; c=relaxed/simple;
	bh=eVvkeQWqrG4dYBffY48He8ILJTh8EX7LtPQhkX3h+lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHe0MlsSR17Loba+TVyZ+TlBOmhKiVkwSDImbBCY3cFucYBWI3BRs3zEvA+rzKrBw4aR5HITUzaKw/+fRBk+nTyiePsdAPucMI0bhW4VLwTJgVpKjbcX4NPO3NjKodrSiV6Qst09yGiGR4uYirPy8ceDgWjJzjNeoKqF/paKZl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCnG8vPR; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b58445361e8so1649571a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 09:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760027035; x=1760631835; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j4C1j3OOKsjCqjPjMDTFb2+CfJ4gki9Qbk/4PqhkQDc=;
        b=MCnG8vPRQYAB/sRTi4esoaO/JWYoy5ApLLqeX6QndxwVYySMVYJKfC4gJjO3FwPqSV
         S30/FC8jXscm2L1XPxnjUqDd27oc5xOjcOGAGIa/5BlueteWIktVI8o/v3dMZDbmDeF8
         z5AR8SUuVLUDndif6y1kd0i2+o7Wee/2h2SVC/9uVSGcm5WK5k7oueRP+T90pEh+XE4a
         1d/kTqHfwlX9LPsj0YGzfnpL06PNlMtzs7tRQTGQIyBbwtT+lH5U1pKcVbVIix5OkX9B
         3adjH2abP2vWlPTF0J3nPlLFMQsmVhism3zMR9wh1pzs/U7nQ3hoL6WTMqh4mJNEytzO
         UfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760027035; x=1760631835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4C1j3OOKsjCqjPjMDTFb2+CfJ4gki9Qbk/4PqhkQDc=;
        b=E6z5XKTglMkl5VJHeDJj0Ci8WlDKUUbsSFqaam0xDYvAhSnQj2IUBk9qa/RqkK4A30
         z1XV3MtE155d+C9TbihUDe+VewJADqQlevzBmBjUqdxPj0Br191gZcy0cchUBUaDxIIE
         enbJq70W2QvR8QIcFGaEWztRqVKunY+DPrF4pox3dgTpUfYuHopoa4aQpImHaQ+spxG7
         FnFuDELQoo8uZVx//KI+nanni6/Q1cl0VNFA8LK71TvnY3YSsdlPRfMBC1xhFSqctcIv
         f17d2WwXTDv5GnoiIJ0ekOsBq3AN/kDkK2cKl8JS5P+oo9ps+zrJN4kv+Qe1ToJZFg1e
         KVzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrKuu41Wiv+4qaVI5IyabISjU3FsF4wBE9RRWbJLe1+dfFq3QSvKSFN/bYRMZTYXvFA7bGRIA1KSx12cU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXDqDdIAPXjP1WJOP0urbHDz+9gr0FIVC45q6HFA5wE3G3ZYp+
	v7pZ81hLeNifrsCCFab6ecHlBSu05fBr2xba4hI3hsyPNsEVX1TCidvs
X-Gm-Gg: ASbGncvq9zsTTFgAWbYSk+N8tavz+QHdDls8guI3lED7Wfip2p7MyanJC8/8EMDqkUq
	5EeitPIcgdxzHD9e2N8vNyyYHyR/FwYY6h7+JWcGj/2FePNGK+eQ+rV5DlpZHIgMXtnGVeF/di/
	Q1p+GgNeUKUXJZvI1JHLBeyk51XebRy8tBEP5+X+bQpkzvPFvX+fUUF3GIeDStdXkn6L71Gh/qG
	i3KeURA6OevRhjsSTs/cMgd0N/ak3DjeEt/FCA25Jk57YyW80vYhxlTm8dZvZhbqIw2WEpDWLZu
	4J1iUlKmP4JxLOWDATaj/OC6TaxKBscHc77f/PS6HZXul0h5de2QzG0cNoV02hAnNbSQWzEifO8
	uzk7+hZzrzMHALnlQsdy0VcEJW8e8k1McA8ZpduJWVZQl48DWLKDwUDY=
X-Google-Smtp-Source: AGHT+IG5iTuS4lml5ybOjWvkOCPTHDj9ZrBTt/dnU/W0P0sGl3oiFllm8k9GBt9WpwjupCqN6+ivSQ==
X-Received: by 2002:a17:903:1a10:b0:271:d1ab:17ce with SMTP id d9443c01a7336-28ec9cd59afmr138719345ad.26.1760027035566;
        Thu, 09 Oct 2025 09:23:55 -0700 (PDT)
Received: from localhost ([2804:30c:b65:6a00:ceaa:2ed0:e81e:8f51])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-29034e1854asm33475565ad.37.2025.10.09.09.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 09:23:54 -0700 (PDT)
Date: Thu, 9 Oct 2025 13:24:54 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org, ukleinek@kernel.org,
	michael.hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	corbet@lwn.net
Subject: Re: [PATCH v4 7/8] dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216
 and ADAQ4224
Message-ID: <aOfh1puxPJr367n7@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1759929814.git.marcelo.schmitt@analog.com>
 <7e51e036ba930284c74cf42afd53b17d49093654.1759929814.git.marcelo.schmitt@analog.com>
 <20251008-penniless-tiling-9a83d4b4ba48@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008-penniless-tiling-9a83d4b4ba48@spud>

On 10/08, Conor Dooley wrote:
> On Wed, Oct 08, 2025 at 10:51:37AM -0300, Marcelo Schmitt wrote:
> 
> > Change log v3 -> v4
> > - Now only documenting GPIO setup to control ADAQ PGA pins.
> 
> > +    else:
> > +      properties:
> > +        adi,pga-value: false
> 
> I assume this is an oversight?

Oops. Sure, should have dropped that.
If the device is not an ADAQ (no PGA circuitry present), then we should not have
properties associated to that.

+    else:
+      properties:
+        pga-gpios: false
+

Thanks,
Marcelo

