Return-Path: <linux-kernel+bounces-743366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 940EAB0FDB9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 01:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2313218992AD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 23:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4115726CE08;
	Wed, 23 Jul 2025 23:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4Gnlzmx"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C83A111BF;
	Wed, 23 Jul 2025 23:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753314263; cv=none; b=q2B4iryh2G8NwTBjYMwl9CXGA2irVsjrliZDOFEv4Kj0pSFaUqW3ue0CRzbmlDmUuzH855AaOMmf+OxczKB2NQxMxg/x+kcR7wPo/BxIZzGP6OFeuQggKB6sfE7XhuP6yF4/JHd9sc8mkVvRNJm/+gHg0TPku6c0plnqaXWncuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753314263; c=relaxed/simple;
	bh=NFMZcHmxH+7tGrivjlfbqsit7c9Wdvhu5x2EGP8PyZY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBuwstu3TCRC34vNZxIftiRUFpzzBaGbwuGaMCVhxdbBunnDjecWoQnaN/qM9BrAWHZibrnBNdjT9MUBc0LvcX5AjATE7Vm91afUomK0uLjnhQt4h1wrEfdp7h7EDOGXGUbtHXjdB3GgWz5gcEILIi6TLHtEP/aCv8oQG5m1MAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4Gnlzmx; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-234c5b57557so2946245ad.3;
        Wed, 23 Jul 2025 16:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753314262; x=1753919062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=egOR95e8pzUIXHVjCnVm2bcSsTXIg61tjStS28c2/fc=;
        b=N4GnlzmxL/vxZckL9Tl5K4c0xOf+L1Rp/N9Ji/M4ephbo1gJBkezSxFPcnn9jIpJiz
         JN5cTjEN9irluoSUtmHRTzS/H7P+mnjQn4kPPt6VWh/nx19zIK7A3mY4zP94S5UmF2uG
         wf+zHNGQdXzNdhS/PIInr8ydvkY2pV8asykjwQKCGZ7qLQlCe82qBTGnpoMcxUnbFo7T
         RSS1chRJT64TV7g95xoBxin+pldqGh/zILI0t+qheR/ihe6oxT1cZLnzf7dGN+sQoc2s
         7XgnTzDr8cuekF5+LeL00J7ibOd7fQx//m25wLGVa2jvaONtWdcaHSIBsDpWx78wLXvN
         2GFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753314262; x=1753919062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egOR95e8pzUIXHVjCnVm2bcSsTXIg61tjStS28c2/fc=;
        b=gM5Nn8ymAvchGynVljkskGtyEq7e2W0KhP6/NcBHdQqLdFXY3rIQpitVMtlhzUA6xV
         +l7jJa0ty/fS5gjduMs5HzcVYmwld6iTknNCiLqk/ud0TQNOky2kx7r4XGPop4DNSzii
         4itY2rL/Hh9Vv+QX3eeZ5iR28IsRhDylsZ19eMlzSyl8spdT6qdEeo/mpLACNTOxyf4M
         JHekEcSlUexHZiHv2V9m20klpeUFSONISCLQiBTwiIQQhdzXvORJikv5rHtC+WaxLGLd
         gtfd46Ratc0o4NmIcJhQhJYmr7UPXUdFOLe8/Roq1DkAK0Z5Cv2L6YF+2ukcYOqf73Lx
         0OTw==
X-Forwarded-Encrypted: i=1; AJvYcCUrwxpTKByTXrEXrqA8T34QQRC6p80uWhMfEoKSFrCKJ50V7vf9eVGGv5ish6lI/tEvGLYslPoUhGTV@vger.kernel.org, AJvYcCWAFdkwCffolF0zm5LR1eUcJlC5eSWiVeboDfFfTrjim10GGHtea8tnmQCu1eU1OlKzOq3+E2fXGP5qV+Hd@vger.kernel.org
X-Gm-Message-State: AOJu0YzlBlSq4ywqV/C/FaMd+P+I4pN7GcDi81Dk6lK4HmMnt4VTq3Jo
	45bAI+6wFruV9OL/Rc3P4WN2c5R/1vzlcLu76R2XPP5nT3jAMVTYdKyG
X-Gm-Gg: ASbGnctvI4WTRPYhGiJAtUg7sbDoMgNmmjWAgdPYiZFQnwWrFKSkDII3FYwqHQTlMrc
	hB54n7f0C/k8exy4IGn/akCRUEBC7oQfB6n+9LtDdjFZ93bfx2uQCg4hZF5vaN5em7dXTbEPEuv
	upyi87TYHcY5CDw2Ny+rY5zUeN2d73GHIN96o5XfW68/axIPna4Za/T/jSLU5oEcDI20ENb2uhC
	VpF+1KLkgK+p2OJxi9ZmW22qEklLA4uL2RSWRtnWBNpKodmK2cOuYvy2k7uMQm+rhU7ReUh+6cu
	foY5NNJV42ooE7r1PT1/aeZaont1LXpLknSzTo3tsLzrnrv66rvwCiyLJWQEyWOluLTlJ4p2Apr
	OhVff4/szoxoRw5qB3fwC27dJtiYx5/zMOF7Ljrp9HTWIP3ydz4ICE9NEx8A2nL5rROZZfplJ3V
	8=
X-Google-Smtp-Source: AGHT+IFDzS99qUj6bsQTcDicde763FDogEGZYIzf0CqpnnHK6ECZzmfcAqK3CJqUDBhhH8jFJnC1JA==
X-Received: by 2002:a17:902:ef08:b0:23c:7b9e:163e with SMTP id d9443c01a7336-23f98164116mr54444835ad.11.1753314261687;
        Wed, 23 Jul 2025 16:44:21 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa490222dsm1371765ad.182.2025.07.23.16.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 16:44:21 -0700 (PDT)
Date: Wed, 23 Jul 2025 16:44:18 -0700
From: Tao Ren <rentao.bupt@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Tao Ren <taoren@meta.com>
Subject: Re: [PATCH v3 00/13] ARM: dts: aspeed: Add Meta Darwin dts
Message-ID: <aIFz0nq7qHvzglwZ@localhost.localdomain>
References: <20250723233013.142337-1-rentao.bupt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723233013.142337-1-rentao.bupt@gmail.com>

On Wed, Jul 23, 2025 at 04:29:56PM -0700, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> The patch series introduces the initial device tree for Meta/Facebook
> Darwin AST2600 BMC.
> 
> Patches #1, #2 and #3 fixes the DTB warnings in wedge400/fuji dts and
> ast2600-facebook-netbmc-common.dtsi.
> 
> Patch #4 moves eMMC entries from ast2600-facebook-netbmc-common.dtsi to
> each BMC platform because eMMC was removed from future Meta Network BMC
> platforms.
> 
> Patch #5 introduces new BMC flash layout with 64MB data partition.
> 
> Patches #6, #7 and #8 add "wedge400-data64-bmc" board. "wedge400-bmc"
> and "wedge400-data64-bmc" are identical except BMC flash layout.
> 
> Patches #9, #10 and #11 add "fuji-data64-bmc" board. "fuji-bmc" and
> "fuji-data64-bmc" are identical except BMC flash layout.
> 
> Patches #12 and #13 add Meta Darwin BMC and updates devicetree
> bindings.

Hi Andrew,

Sorry the patch series grow bigger and bigger, and thanks again for the
review.

Besides, the patch series is applied on top of the latest mainline, and
we may need to rebase when v6.17-rc1 is ready. Please let me know if I
need to hold my patches till v6.17-rc1.


Cheers,

- Tao

