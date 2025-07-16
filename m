Return-Path: <linux-kernel+bounces-733734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A98B0785E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB34167084
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1C3262FDD;
	Wed, 16 Jul 2025 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQV9YA3J"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FED208AD;
	Wed, 16 Jul 2025 14:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676978; cv=none; b=CgrgOLv1X/J5vVcNH2OekAVNEEiNnd27pHHTkRxcBqRGpbS+zRtIAgHamJ2WhKzFzkMJGtrQuJCeexWB+eyAUOHz3GHZ7ZhvwZW3l3mRWfZk/aMspmIA5APHBHfc0uqLc49QsnTN+exntT396HDtmCZVZdzd4Yi4OdW1CoesPZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676978; c=relaxed/simple;
	bh=IAd6FGrTOnFlsfoLEXylbpURFbSM2zQvX3rpv/2c8Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gg08PMCC0kYTKS+K7LreiQ5+AtWVHX0+a+819F6sJzSLDADsPW/7DSiyRacxdewHpas56hV9ODydqtd17uVn6Xf0HMN0pD+tQVTDpe90Ne27eAbh19Mrn1qtpAMi6BWY7e31siPT7x63f6Y+1IJGA74B/hRDma5FdHgPtTqZZCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQV9YA3J; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b350704f506so10531a12.0;
        Wed, 16 Jul 2025 07:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752676976; x=1753281776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HrmhfqwuOeFzpsTcMEpOex8e00HhWOAyQQZ7a9DYdsw=;
        b=jQV9YA3JqW6lrokeX1JJeBJcukmsJ/8gROET6FsyYCG5wAvbNfJ4doAzRdrFNjdUbk
         PQLMum7+IZgMLI0TpwZbuGzVUSPM/8Slkiz01FtdKtVygFVJVGtfCoJi3VV7N47SKkg4
         auP2X+IN8Mg3e3mWCSiu4zAjv9e7DnSXXMYfgdd/fBrQHYxEh1ec65nXAWt3MIANxQnH
         H4JFwR7CtI2OAPACT+ERdVCgSws6P6UcJhiDgWZPUApN4OVKchTTAGOnQvySEU2Ohl3L
         aHYFFoo9ltXg2c481Yh9aNy3MFzBZ+akOOpL01Ca/R9xytqzWkLk+GCXZa03ioVtvBig
         9aHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752676976; x=1753281776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrmhfqwuOeFzpsTcMEpOex8e00HhWOAyQQZ7a9DYdsw=;
        b=oECFPkkjcA1M7QbIpoAh9PQkrm0PavAL5DBVo6nQb7EI1kMGisdt9b+TlslUx+xkPP
         7UjKuC70m61+aGv5E0VV2nKpuKG0rk95AVbOecxC66jc8x9iEV3CsUfnQOhiHwJvbaLU
         qc38Jz/eqIRCKp+N9OMLFvpx0iPt0DAfJHen6XWFAjPIPbF0rL38hkC9HBWn46wvCyvR
         68SY+1WuKkAaAakaxn21zxFjXYu6+V1kRlwbXAJESFsn63JF0u5tYo1hfTdmHHIHd43N
         D4Mg4MIwNJNdnKeKFV7E76DhC8H5hKA5AqNqRvL2IO0GiInqV6Bem8sykHnFbCJQUnG8
         G9Iw==
X-Forwarded-Encrypted: i=1; AJvYcCU0SIzVgyCf/aTL76SF6YyfvgitA9HmZzSRm7e750uYPg4czdFaOi6qg5H7fdQ/2tXYiQMgTHXETS/G0Go=@vger.kernel.org, AJvYcCUvEFg/cdZmVE0KAwQswix4I4zfMvjOilLxE61OpYkNYEitr1ihnR9M88K1JaOCCc+2mWW7025BmmyP@vger.kernel.org, AJvYcCWK6BoZ3tq4FxlXI9TDs7i6blTjLflIAvR6Wejf6jFPbta5peEeRljFSBVmSpzrVYBtwqSrO0Ee32eZJ0M2@vger.kernel.org
X-Gm-Message-State: AOJu0YzLEpGBXY3i/XqRfJ+PBkd7knBV3wU6LkGk+/n4ruD8siF9Vlbj
	SbvrHpym24DOpPYt7AOOY1l4SsFBxygi+cu37I10jXEDPOv0zptJSaKI
X-Gm-Gg: ASbGncsKCxk0NiZhgJARozCR+5Cc7mIPFin6EcnYk43i4cmznfpGMOpCebkK7cOp+KS
	GNRJzhnjgwcEWregWC1dUruAHArfJRQvQxQebIzF5QG4Q4xkLIdunAQ2HWVOX5BrFflIxv3jlon
	j45B0CdFqg5ctecE7C0HcmpQvzFZQRoAJBV1ukCSBvUQ7QzfTi/AouT7qByLIuot/uJlRLUFIku
	TqQKMQ5T0yD0wfFf3jY56MiLGJXo5x/FpIFYJslD4eeRyosWRxECrbmPcIfiWvn6lgJbs0ITfJ3
	KC0DqB2v256fJQlzMhEJvQexHUqLMaw9eeOrTIcKoqE+AgUrgLjligUzzyZI/DWxVIbwKIc9atX
	5GEMh649bg9DpBC5puhL0KCcWe5OZFPEMR7yF7SZubnnO4w==
X-Google-Smtp-Source: AGHT+IHObnP8GezmxTlYlIYtkOUzK6Ep6LQLCbe4+JRZX/WB5H4tbtiYyfiRybBF0UxHRZ5aN1U4Ug==
X-Received: by 2002:a17:903:3d0e:b0:23c:6d5e:db4e with SMTP id d9443c01a7336-23e1a43ad36mr123801255ad.8.1752676976182;
        Wed, 16 Jul 2025 07:42:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe719d07sm13946337a12.63.2025.07.16.07.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:42:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 16 Jul 2025 07:42:54 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jim Wright <wrightj@linux.vnet.ibm.com>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: hwmon: lltc,ltc2978: Add lltc,ltc713
 compatible
Message-ID: <d17a538e-834b-4d0b-9c82-7d1a939831c3@roeck-us.net>
References: <20250701-dt-hwmon-compatibles-v1-0-ad99e65cf11b@kernel.org>
 <20250701-dt-hwmon-compatibles-v1-3-ad99e65cf11b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701-dt-hwmon-compatibles-v1-3-ad99e65cf11b@kernel.org>

On Tue, Jul 01, 2025 at 04:00:42PM -0500, Rob Herring (Arm) wrote:
> The lltc,ltc713 compatible is already in use. Add it to the lltc,ltc2978
> binding as the device appears to be similar.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Applied.

Thanks,
Guenter

