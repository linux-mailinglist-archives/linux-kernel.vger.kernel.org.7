Return-Path: <linux-kernel+bounces-814316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5468B55258
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19F73BA2934
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C7930F924;
	Fri, 12 Sep 2025 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iKIr1OvP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6809831280F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688679; cv=none; b=OJMaf2utlRb1H2tDVwKsz5OSGMaPMTrhLhx1WZqoAqMywfcZ4Gm6XOtlpVL+K70lOCJvM7J/S5+cZi5f5PWvlUM1xe2j1a+bqlufWJVR11HsXPpKvw95p5a9Efrlci2pl6s5QOCam3svCyJbhNrohtbTt9woOYv4eDnl/jSQAPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688679; c=relaxed/simple;
	bh=uk6E5Paty7fp1wof3TD0JBLDuNVPgNqH8AUiWEIMf+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Juk3jS/TthqGhLSN9ryiZcAvBjwNos8+IoUb1j8MohufW9gZsvYBeNAj6ONsQTFlVnf78C0voqX+UtxjnRvYl36fbZqsxXpXpfk0ifigxZjrxxEjluKbsaJZBhshgJQTA+0pG44b08Dd5zgeScGFfUVoAlElTpxN58sMnvm50Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iKIr1OvP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757688676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NU+SVzKeTWD0+BhYK3td1Pqzo+tTZOjwzHuyU7qJoZg=;
	b=iKIr1OvPFqOM54Bae9o3VBrP3eoAxITH+vi3c6A7mMF0kd9dGC5uDB2KWmFPn1TV0/H6N4
	eroVOKHkrBPUGeluYpGWf1b0QgURUNHQcBxmCRuYMSbOjWhugnEwENwNrqZlnDGyj42Axd
	htq6FZiKxI+wVbAEswQqXzAlc+MgbII=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-qrPGwjgxN5Co7Qv_D4tocQ-1; Fri, 12 Sep 2025 10:51:14 -0400
X-MC-Unique: qrPGwjgxN5Co7Qv_D4tocQ-1
X-Mimecast-MFC-AGG-ID: qrPGwjgxN5Co7Qv_D4tocQ_1757688674
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b5ecf597acso48446041cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757688674; x=1758293474;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NU+SVzKeTWD0+BhYK3td1Pqzo+tTZOjwzHuyU7qJoZg=;
        b=r9UwuX+SMu9t9grp7yZQSwC+rzb/KkcypXFtG3zVe4UHquh1PKI9+Rj9eyKw/QVITQ
         NzHXUI9IeGFbIVrkf5i0V48FeP0Zg6zA5uRhqggQysMfDD6E+HBLpclgm6TTHeNiFDpR
         NyKGIWs8Gmc3hLSln+D9JOw9MzfyAIN/tC+LjkeiYFydVxal4+Xi8fudmuVjZlTgMGcy
         GrJmr8IHX+twApRTDQr+0dAvKFWoUMQYMw4gZ8ms7+eLwh5KiwrlQ5c4U1Ic2azkAlDv
         3RFGb5iJROkXLzwiNpjadnxyPgc49MxcpAqA5+4lwq6Zj1qHSEufL4I1c16Ppka2b6yh
         QSnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqjfzr8oz2XvyXzvCfQDdRjczZmzQJTwvPgzPux2Zh9y72AhLK9WaNiFZkRAxQVnvUGkmh9i+eLdqny+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPbDWuYqYzxBPvG9sU5ZJ3sDZsQE3IDv9E0l3bwqAJP9V5TCR2
	nd8sbxL57/jTfYmYVwpWBnAoemqQtYZpotSQcpD0UuM2g6yVu36ICyZiQxv3/BfPwFLQ77XeQZN
	vXXgi5DUjFZJbUXmU9OyqHE9/f6wcjk3GPx4j9pJFpOBhrJXUQVfCW+6MMjul8MQjrA==
X-Gm-Gg: ASbGncs2DUAA6nzur69VqqihrJkkq/iE7sP3MmZ7bqqfXYxFtTQx1Ytm4GwOJoI3NLU
	fQeUKxy2mUKAGIrjpW2mW4Dk4ry51u/1DcDCiZ+QUfJlbxp/5c6QGO6jWIulhTV6WRAXU9tNVz5
	W9cys8pj0ASpLoeMz9D8JkHt1+J2QAMKB0RXDqC1r0Vg+j2xGfXsE/i/PmUQ2Eh7gujgII4IAhY
	ymVU4EiUHoDoW+FQhHcz9rI97dCS6K582aygoS39peANhIkD6bYzLK1eCemY/+YAs74Cm/N44EY
	a1H5ar9wqFwJeVE5F2HNIONrBzD8wGT1WdCvMRGO1ThqON3y2iY0gmZAdIKhxFB+LFjK4GeusKQ
	S6vAwMqKBz4HLpjFDChOEX6NrlBPxJw==
X-Received: by 2002:a05:622a:1803:b0:4b3:4b6d:ec52 with SMTP id d75a77b69052e-4b77d0cc905mr42168461cf.32.1757688674182;
        Fri, 12 Sep 2025 07:51:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKHaF5tvFQHHNEZPu3AfsN41wRwe2BP++0UPlIuNaDPH6QWUiaDDqVyOq53mlk8SSAOAXHkw==
X-Received: by 2002:a05:622a:1803:b0:4b3:4b6d:ec52 with SMTP id d75a77b69052e-4b77d0cc905mr42167931cf.32.1757688673567;
        Fri, 12 Sep 2025 07:51:13 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639dcae6dsm25920811cf.39.2025.09.12.07.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:51:12 -0700 (PDT)
Date: Fri, 12 Sep 2025 10:51:09 -0400
From: Brian Masney <bmasney@redhat.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: clock: Add spread spectrum definition
Message-ID: <aMQzXdVHOGoT9y4C@redhat.com>
References: <20250912-clk-ssc-version1-v3-0-fd1e07476ba1@nxp.com>
 <20250912-clk-ssc-version1-v3-1-fd1e07476ba1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-clk-ssc-version1-v3-1-fd1e07476ba1@nxp.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Fri, Sep 12, 2025 at 11:35:50AM +0800, Peng Fan wrote:
> Per dt-schema, the modulation methods are: down-spread(3), up-spread(2),
> center-spread(1), no-spread(0). So define them in dt-bindings to avoid
> write the magic number in device tree.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>


