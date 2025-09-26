Return-Path: <linux-kernel+bounces-834642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B944BA5298
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 23:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 475D14A7D67
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 21:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD3828689A;
	Fri, 26 Sep 2025 21:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WcyChExw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECF4242D69
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 21:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758920931; cv=none; b=kNka/Mqe4QTsylCnNTix0bOdgfxWsjjk0HVv9+MT528mYxDvW3Bkoqqk6/JryZ4cONPuWeckgRZzSpaqLwf+LeP5kntuCkO8p8yf5o7WxRXvwT1+I3tY9gpv89Gvajz3QrMdyTIHALwte5oswiEfz9LGyd+knT+tah5qUeyF6KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758920931; c=relaxed/simple;
	bh=Jc4EjceSLmpDjEcyfGiNWZ65Xn1oM5ndssYe+GwUZgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvURC8GLKmi8woQJFNlcENFoEAHwRsZ4HQqXFcGyWKFEjx4Ph8bziPjQjA4Zc0yBOvYxRJiqLd9Zoa4RVC/hCg2Mh1eyG34Wsk7oinu2z5gC0+hA0b3zjGnWhBTylXNzeQBwQ2Bx+oKJ0hP0dsJeglCNBzZkzeAzvXSsPOD7t1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WcyChExw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758920926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y3GVZ1JYDpd64aStls1BI0HpVUBRoCJZmr3t6BifA9A=;
	b=WcyChExwjLMOdsTYGbJrWkPRIXtr70IfNPL/r8ezpTY9DQm+JhyGUjtAFRWHlnkRbZFDHr
	eQcDl+GaF1QQXtoCjkEhFPWYnvacMhJs37IhOT6PAQvyglib5FvkllmG5h46iXKbZcKrf0
	+FuMeOrpEk/9piUSFP+igLwZkFoWl1g=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-wnt7J5dhPwiLMSFcGUSJdA-1; Fri, 26 Sep 2025 17:08:45 -0400
X-MC-Unique: wnt7J5dhPwiLMSFcGUSJdA-1
X-Mimecast-MFC-AGG-ID: wnt7J5dhPwiLMSFcGUSJdA_1758920925
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-82968fe9e8cso641081485a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758920925; x=1759525725;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3GVZ1JYDpd64aStls1BI0HpVUBRoCJZmr3t6BifA9A=;
        b=nZUtV5DjP1ck/qBhxfc+7xbEFd85h5d99vl671c+yMyYGrmy5H0YUxkVHk5lLv4ueQ
         U8eH2gT9wMwLvY+ZP0gEC6qlv1MlX01+ewF7wbc2XZiIW9FgoF3cKlQZisASnJr6E8ff
         OwzQQajmp1U+7nnJ/KKgdQHJV7Q6IqpxvnDK7ulclX3gpOIdv0Z6b93caCe603E3JO3C
         AxXq13AT+2xikw6jGiT8p5s0fQufeyFMgrOnC4hhAZ9MQdvDbjjeChAqnixGKqJecAnQ
         VPnnzEX8Fs2CyPCj427qcnapvVzh6u5ReqSXpILzzcJaFec+Q1lrkFqJnRUYQoD/L2kD
         dRpw==
X-Forwarded-Encrypted: i=1; AJvYcCVeZkz50/oG7rsr2VqDL6Oc9OZuXBHJB5ZOyACN1483D7JcQCjuWqAqktbB3CcXzqvV+qaFUJOeqJ25tqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhc4EGdqKbr/aVIw87VawjS47QnVFxf9YFkkMjsvVYhpAfZ4HW
	Bq5TQhoU/XEcbvfACX+vsL2JzIk0moO4h1TT2sZkp308ewMHKcsvIJk4x+rGjgnuIiwJnpSbBvU
	lZKfofgca+PAUwtm2h1WhcGFOTDVImZINLNMQtKZRbpffa/ifNuV0qiIgzbF8Baayhg==
X-Gm-Gg: ASbGncv++Vi8msEKKWa15qmb/AjULNnPlVpDEVwBs5iEXcWVG8jiaTyq5OBkUpZ/Fuz
	oZfFzYm/nN7rMlUpJqwPrA/LuJ8rRl2eexuUcWeW8aOAObTwg35PKjhp8vDsQjzM50+WosusrYs
	BwV3Mm31qcTl7aYcUIqNWsd800492cjN8FX5XrGETPz/dbD2T4aHzwS1bpmXdWU8ZfdloSDUpTh
	tZpWLM7SmuErrlaR5nWHDEecTHnLimoP11UNe4dopevL8O06ouzwQKJZKo+5UMY8mPh1XVFbi/w
	w03iaqFxejKBL5okGvOGjC3htZ2ZhxP9xlAp65OsFyfbPPZdJ/EeCgSj0df1mgPYnYgaAflGS0X
	iy6ctMeUQcea2uU/r6VILbDYVI9KDXDU=
X-Received: by 2002:a05:620a:4722:b0:85a:2def:2fe0 with SMTP id af79cd13be357-85ae033d4d8mr1349869085a.22.1758920924970;
        Fri, 26 Sep 2025 14:08:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJQzW4JZ3je9wirGSfh6XIDEj/iDBCJuS1EQrYgcojfBD4UAa9IhVt5/kN4bppw04xeCyjUw==
X-Received: by 2002:a05:620a:4722:b0:85a:2def:2fe0 with SMTP id af79cd13be357-85ae033d4d8mr1349864685a.22.1758920924446;
        Fri, 26 Sep 2025 14:08:44 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c34da236asm340619385a.68.2025.09.26.14.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 14:08:43 -0700 (PDT)
Date: Fri, 26 Sep 2025 17:08:41 -0400
From: Brian Masney <bmasney@redhat.com>
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>
Subject: Re: [PATCH 1/2] soc: qcom: ocmem: fix device leak on lookup
Message-ID: <aNcA2SCZMckYmZXb@redhat.com>
References: <20250926143511.6715-1-johan@kernel.org>
 <20250926143511.6715-2-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926143511.6715-2-johan@kernel.org>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Fri, Sep 26, 2025 at 04:35:10PM +0200, Johan Hovold wrote:
> Make sure to drop the reference taken to the ocmem platform device when
> looking up its driver data.
> 
> Note that holding a reference to a device does not prevent its driver
> data from going away so there is no point in keeping the reference.
> 
> Also note that commit 0ff027027e05 ("soc: qcom: ocmem: Fix missing
> put_device() call in of_get_ocmem") fixed the leak in a lookup error
> path, but the reference is still leaking on success.
> 
> Fixes: 88c1e9404f1d ("soc: qcom: add OCMEM driver")
> Cc: stable@vger.kernel.org	# 5.5: 0ff027027e05
> Cc: Brian Masney <bmasney@redhat.com>
> Cc: Miaoqian Lin <linmq006@gmail.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Brian Masney <bmasney@redhat.com>


