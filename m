Return-Path: <linux-kernel+bounces-825971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C09B8D3CE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 04:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FED2189E989
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 02:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC853199252;
	Sun, 21 Sep 2025 02:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c34fqZ4A"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB11156661
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 02:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758423097; cv=none; b=IqywlXHahxSq0fLpx44PwFSzoY9b2WQfGt4JtZrlj3uJO7dMEQ1Cae6qQ3epdAzJsIhNrkh88nmXRgD1UCTC6wEGdU/21AbxHte3eQI98Nuq+ii75E8nhJWNUy93bMpXFyTDcPWJ/0rL/GJz9bVo0SVflH6sBj/5WKQWIU5Amr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758423097; c=relaxed/simple;
	bh=lBKwjGlD2sl3HW/InUD61SetLUkGpSZmLWIOs3WO++0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVJ5937W5sIcKwBbbbv39OB6deyQ35gt9kZVhNksBps8Z3JS+Z9unHexOIdoW5Vmus8bl7pLzBmodvwy2us7gMmDhz3SDhZarm58WZ9+ZAkiNf6KMmq736rY1Ub/NQ/UncMJ9KOHaYahI3RJTkAdFgWHlfKkDleHDFL3Mid8h5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c34fqZ4A; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-77f1a79d7e5so975241b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 19:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758423095; x=1759027895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uNUurTQ+hy6CY4Cjol5+Pld9O12FSqVbj7oLrH9uB4M=;
        b=c34fqZ4ALdicuB0rvpf7UTTZav8oKwjvwDLljjOCh+9QFOyGJsTCnuTbRnK8w1jwrp
         4pcM49o5An3ayeRaiM7MjB3sOCcFubvcv6TA2JT9v126egfj2fZXPaqifXyRGHOujvlf
         8brHNqjWyBGQFk3o11FifRq5cC5lIrtmONe9mX+4078r/yB+oD6clyv5/TjGBKTU/TVt
         v7CEzmtbF3Vz0Q6bjP4YzZY/HIxSJ0jdCMokw23FLA+Nv+Dux6dlkuJBMw4SsLxDMn7r
         hBFK+bosIqwrw2m7XiQQqIgW7dolitXCZAZsETdSis3yS/OKb3GiWqY2Vi9b82SPtHaN
         PvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758423095; x=1759027895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNUurTQ+hy6CY4Cjol5+Pld9O12FSqVbj7oLrH9uB4M=;
        b=GTZ9RT9JDVRCRCB1SXkgkawon4+Ho+temXIEX+HuDlbfdHmV1xALLxMT1A18I9/djG
         WQ7vYfO0jhoxKILUTqOltooav0D4lkR9fmMAKlmdbeaFfpfqB62QzYCgR2/uKuwm9mc/
         7LzQlBfCOfLrGRbAQg8m1j70OPNaBzQ3/yeBK16ozWLZIRJbWha2atn/pxbJhitJpqFr
         0KWCL58IpVppi4d3MCejUttPnWq5lj/M7EfMrgxwheSUsnaydhCqBPQgS+h3sIud3N6A
         cXpu1Rbk4i2JecisW6bNupmoegW1+gwOa2OQ1i4J980Z7nUlBk/VPZP5Xija36Tv6AWZ
         kjpA==
X-Forwarded-Encrypted: i=1; AJvYcCWdJ6JqgCJVnGeKQCp9oJvIGJnaaxdQkIWZhjTqgXkSXBlUEm6Bfi6pFaIY9Ft4jdXLOvng++o5Yiitbkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPdaf+ON4no0jITCY7vaVtLUZXO2NmOxOAqNQvT4uqSlMHTYTZ
	TtHtpgTEjJftO0b9VSm0nfG45gxiZrYgAWQCjHDkJ63reO3MW5lhv1ss
X-Gm-Gg: ASbGnctAIGU7kCVVjiS5vYRQRU3vfUMbS0sYd8SCXrYUZrqT/sgw+zJEOim6UKpNPnk
	+TPp/Z6D0N/SeK9rxX6NP+k5YoOqDYwYak294brzhsn6mK1wlB5prPugWiVozUYq28B8OBSnZ+/
	oWPvtmqflPqO1INEk8qrJNvZZkNNhm6/rVP0/ZNfx/1UZWX//mqURJY1qNHOeoSp/+OGju6/Vbx
	I1qYp44EBlMup29XE8Amg5e/ZXV1JyppOHfBCg6bQo+8bce2nS+Espwuer3gpnCtrpgJ+N5egbP
	CIH5Colyu/nx4/IZFC28/64iJ18BtVZ3TCNIZ7SM0WWRjq2UPOzLPtPzjXNWg/zkstqgliOluzr
	AAmg85/tr5PE2+2SOyzPVUYuGsk5Pwwo8kQ==
X-Google-Smtp-Source: AGHT+IESujOc+8Y6ELJdqssqI+rnI6S3xwgji1KMFUZchDD3lbjMYc3GMQ6PK1vBR+/eIGQAQZ2CkQ==
X-Received: by 2002:a05:6a00:3e0a:b0:776:14f1:492c with SMTP id d2e1a72fcca58-77e4d327e41mr10079127b3a.12.1758423095044;
        Sat, 20 Sep 2025 19:51:35 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:fdae:ef9f:3050:cdfb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77e70c06ba1sm6029313b3a.67.2025.09.20.19.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 19:51:34 -0700 (PDT)
Date: Sat, 20 Sep 2025 19:51:31 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Russ Weight <russ.weight@linux.dev>
Cc: Marco Felsch <m.felsch@pengutronix.de>, 
	Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kamel Bouhara <kamel.bouhara@bootlin.com>, 
	Marco Felsch <kernel@pengutronix.de>, Henrik Rydberg <rydberg@bitmath.org>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-input@vger.kernel.org
Subject: Re: [PATCH v3 1/4] firmware_loader: expand firmware error codes with
 up-to-date error
Message-ID: <5tlhy2jl77etqxsna42ksdmvu3x3bsp5c44poshkt45agldfsj@bkzlvbfoshsl>
References: <20250821-v6-10-topic-touchscreen-axiom-v3-0-940ccee6dba3@pengutronix.de>
 <20250821-v6-10-topic-touchscreen-axiom-v3-1-940ccee6dba3@pengutronix.de>
 <ifdhjgo6wchlsztqvgkaawpbnh3zahb76vmyzlomokfrqt6tjp@qjcdvcdqviag>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ifdhjgo6wchlsztqvgkaawpbnh3zahb76vmyzlomokfrqt6tjp@qjcdvcdqviag>

On Wed, Aug 27, 2025 at 03:29:33PM -0600, Russ Weight wrote:
> 
> On Thu, Aug 21, 2025 at 07:26:36PM +0200, Marco Felsch wrote:
> > Add FW_UPLOAD_ERR_DUPLICATE to allow drivers to inform the firmware_loader
> > framework that the update is not required. This can be the case if the
> > user provided firmware matches the current running firmware.
> > 
> > Sync lib/test_firmware.c accordingly.
> > 
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> 
> Reviewed-by: Russ Weight <russ.weight@linux.dev>

Does this mean I should merge this through input tree?

Thanks.

-- 
Dmitry

