Return-Path: <linux-kernel+bounces-794329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4982B3E013
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30EA18908DB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5404830F554;
	Mon,  1 Sep 2025 10:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m9iepLqj"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2702130BF7F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 10:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756722303; cv=none; b=M1ZamnsgNwzisBSiEhq8ikfXayGFK9Iniv0VubXCbsBFvkKNd0m0YUG8gxvYxsAH1ZPJ4l1z1puJhg2f5flpflAvS+Q/Ojl6oOFPEHgxKP5wJ8hKJCzNfqPqSn3AhwY0HM6IJ/6gwTUrjuVXVu/FUrGUs4ZvSJ7aAuuHwmKk/cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756722303; c=relaxed/simple;
	bh=3G7Ld1qpychcmtTgTNSsdZQiAfnbhqLqy04YO6fvdYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OguZ+pgbzhbPkY2UCISIPhI8O/TrTAJzoHxJ1pWXVoVsf+hGB8hJDFeK0e/r//cHnOzf4Mzi+cJyhXSqHNZJpzFbWNYTiO9uKMKW17WNcr6QE+C9fc/EdwTym9brE5fb1S0pMFq7MVlmee+nm+Vuxo8k8SSpAFPgR/jYMRCcsC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m9iepLqj; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3cef6debedcso1771759f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 03:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756722299; x=1757327099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3G7Ld1qpychcmtTgTNSsdZQiAfnbhqLqy04YO6fvdYc=;
        b=m9iepLqj1IbnnI64M41hS7psoA8qRIDcO2r50ehlPJxnb1pNueFmpG0kpOMOfFcav8
         skzTcnO7NSEKeuJRVsKPqOkDdu8jtE0oEkgBVRgDkmcssJXqGqZecop7kfDhBQgjkWSd
         +D0JM+DgF1+4wQZFrBiBBLrCs69j9KwrUBXvrFEx5CDAn+39IeH3f+SlBB9FGLxCIqtt
         duIb//Xz8Qwe37OlNUUhWS6a0atK367vob1Qw9+EqI5Hte8gOlG73JCNEdGvJljc6juM
         FRzzIqXS177oFetVeZB4eHA9xm52w8og+sHRqMB0XVgI5SNUaNDn4QUGOoTIdOTYR4Ka
         frkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756722299; x=1757327099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3G7Ld1qpychcmtTgTNSsdZQiAfnbhqLqy04YO6fvdYc=;
        b=IQtlrEJs5Mt8Ghz1n5vHKKzNiKihAxeFf+sg+ZMBDDiPqDWnA+05LOA5thHjY/rVwG
         frvZ210cTA1ZGFUkNPojDGZpTRmApiKdrxlNoFveFm/pCItQjEN5PPzviR/p8B6amyXa
         T88/FtgE9Mchnbuj05txjHlSrZ/CKa1TBERfOEbt+wyrTMj44K105vAxdMtI+TY9vJ0O
         vAHf9g3TqxWo1TnG3XUcVD+8OUz6J+j0C0fMIwrkWKCcjvFu3rBGLRDPQKX+D+VT/rzb
         QMAYNag21CPqts13Cx8xB1TvOJRUQcULPM1Of8LT1TmWt4uxkOATGcEhVOiFuunoCpRp
         Dhqg==
X-Forwarded-Encrypted: i=1; AJvYcCWn4NXYkRcQLSAI3AVPUJam3IchxBfZQML81r2RVKm2xCoRiL3gQVhgja6Yr04ZtIVyP9M20+9RjqAZzPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaQwEbltuGHbbQcTDwSM6IYMpIqmS3fNGmpuz2eUf61LTVvA5X
	WSx8ymTWNYf9CCilJo665kFP94coLsGvVel+pMcy9K8gd3BzXweB6RETmqL8ep1tZKA=
X-Gm-Gg: ASbGnctkVu1lVxwpEdE26YCfO+GTIhF7Wb7eNaScXKz0Szs+jKmBR7w5iiz5G0/jD/N
	Kr2QKtaxbYua2EaNIWrxQSqx2Ym+2VDWvsJRmQhMMFs2+tAoJQtl83hEiz9ovx3AaD2/6w6EztO
	9oiJAt5eRSXuHFxyBYXoLKoESOiO7mrvJAVQ37h9rCmQNI6o1AQ9kwb+Ue9zPmyaYL7bImQGxkh
	e7RFz6/ei/7BluoAyBMMx1EL3uzN4jC52Q83TTXUuTHc4NHScsfy9dEEUEM0eQguQjTdLgBGwGz
	cjavQImBYE9SvdmwhWDD+Y1WSvPfBrazeHkRRPpZxVDywDJCHE7ripR4+bsXseKsh80q3uN7AH9
	436afgKAARmAL5ZBuQDKqSgr3NItIdk3trL9FvA==
X-Google-Smtp-Source: AGHT+IEec6vgPDcCrTDqOTyHepBVzBKIfJKmIoOvk/faBhoaRvzUBEt6+Jlp+ejld3jTxV+5QEbZEg==
X-Received: by 2002:a05:6000:1ace:b0:3c4:497f:ecd0 with SMTP id ffacd0b85a97d-3d1de4ba70dmr4550881f8f.31.1756722299510;
        Mon, 01 Sep 2025 03:24:59 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cf275d2717sm14784721f8f.15.2025.09.01.03.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 03:24:58 -0700 (PDT)
Date: Mon, 1 Sep 2025 13:24:55 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH v3] staging: iio: adc: ad7816: add mutex to serialize
 SPI/GPIO operations
Message-ID: <aLV0d9sLbVRZdozH@stanley.mountain>
References: <20250901073750.22687-1-moahmmad.hosseinii@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901073750.22687-1-moahmmad.hosseinii@gmail.com>

Please wait a day between resends to allow everyone to review the patch.
Same comments apply as to v2.

regards,
dan carpenter


