Return-Path: <linux-kernel+bounces-778437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 878F6B2E5B8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 21:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D41E95E2FC8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 19:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79EE28504B;
	Wed, 20 Aug 2025 19:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6FJj+mz"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCE136CE0C;
	Wed, 20 Aug 2025 19:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755718677; cv=none; b=HLpF6q55ierdZMl66Uq1S3/XqqmS6A5rdKYtAZ3SvXtt3q3LaSm6kCHLX9ECsGJx49GGy4M12FQLBds76R5/ZbPfSnpZoqFyM+NDTCXXgUIAAcPRKiOHZjmhCnEyGm677bW6witl6XGx28qE6RRBFPCaxhNEx8wqtpPgnEz/M7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755718677; c=relaxed/simple;
	bh=DIGqYplhoRs1f/hcHSbYZNmTx5Ex+a8ORKp3qbixI2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7UTVDrqxVLekAB9gnbbqZ1Z1egCN1AF/fuX/51YnfuizFigcoHrHloqs8wTPr7uLrZfOXyBQQG2357/VKd6Rd0zatA6alkN9UHDdFbYc1v+ljjXxP8Sl7/OWmtQLbopBiCkVWy/LvIPwmWxH2r5EtwAcW31iqR1OfsrIDC5C6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6FJj+mz; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-324e3a0482dso217630a91.2;
        Wed, 20 Aug 2025 12:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755718675; x=1756323475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIGqYplhoRs1f/hcHSbYZNmTx5Ex+a8ORKp3qbixI2g=;
        b=Z6FJj+mzKdIC6RtiNoZHiknSJzpr8Q9l5j27y+Y2zx+iSNwUrlFANn1ygg2k975Ucg
         piMmuJRtZ1PWDCxXKcztnhj+/pWhTfQdzN8BrmUeZWEcZga1l7pAXuuOPUEEE5CJYgKa
         XIip4SU0gVsITCH6XCKuMuBYz0lbSx5dRWt188xcOyMygmaHtkve2QxTsrNsRg5WKYJD
         sL+2e+gYu3hWJqACPAs04dSLMuJ00P2G4jOoU6aoua4zO2k05efxEkPF+OWH4t7TEreq
         zCsiwFm2+tddDmjtEL/Icu2JGRcXtJFcpJwkk2dxYvzg0+nwd7f5GmDaOQ8EWtSYceIt
         ingg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755718675; x=1756323475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIGqYplhoRs1f/hcHSbYZNmTx5Ex+a8ORKp3qbixI2g=;
        b=JB9nXpLFQ/Mi+zwm9Xqj93cG1sGfW3mGk2wObaETd1iSPUWwkFpgTHtcWqr2XjTDmT
         X+JVts0gVyamtue4em6TuyRdyfRlRzP7JeidLxHSWqVuzu1e2SVXPwNxSZsZBcYqq7M8
         HlE1oXO/SyV4Q50YYb9zKUVhUWLMNQGAiN7YBcnG+fHoVGeD+BP1iixXjVW9m9XTZPbq
         CNlhSKA4khfuP0AwLEzMJOuA8sYtYb9hG6UXxOfeDhbu5coxgEea/HqkC5/+dqDL1abb
         587Zw3mQGCiBhPrnmdndPq0btBdq3AcWfFBvN3MhVvoCgT89L1MvakFvTZ2ocDpADnLF
         yhtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbysSkDiNaWywmu8ApH+nga43McEPV18H8ctD9jf92DmRq6yO6Z1IKef25E3qyr2mBAJIrTL0jn00=@vger.kernel.org, AJvYcCUn8lYpYfFkMKq+B14kdlbfK10Qy9wnrxNZSgL0GhR0+fgApB2dTEshlkMihPIIzGexqmMomSQlepUXUHJs@vger.kernel.org
X-Gm-Message-State: AOJu0YzMEA7BNwqppClKS3/o6+QJmxeObUlKJ+NLAOzuf0WAD1rPkZxs
	t+usOZ333kvYyjr+mGksNm1vVUIIrfYEIo0qng79ED5DOeJzFL1IoU97
X-Gm-Gg: ASbGnct3hl8IBUA0LkQgRTJHM1oTd/76F7QX3pYzb0zGsfQeGhqIlqTKWOHlcIX19ee
	u5oa5tE2rsamGJwMAE1yVM+kx/H6+jeuoquXRu23UWzjFNZkGsfBpzO8pxGXVhnjJhUFs0ATUgX
	rNdRGr0AaLyqa4RbLKselxivTJryOwtw9WaFTd0uUxpySS42Znyzqvh25x6mi51xUtLbfN695WL
	8+dNKt6ajYrobuyTrFYrt7RZLGe/s9GP0imVVEdWNCYv8EJplQwfxgo/GyQSrY4wFRAAtbnEzqN
	H4CZI3GODYw6rs0RyF4E9FnjdAVXFb3u6BvR6nFa6T0/dPU/zjM5Gv2acN+lK1hiohjZvmQW/q3
	9M6/2wQ1zFiBfGSe6EuPBg0jrsBw=
X-Google-Smtp-Source: AGHT+IH4oAP6ojhRdx0McHVBEZbO37qGzzHPVXncvGS5wiZMCWye6YVPnfJGPtuh7vzBHz8DDQSRGA==
X-Received: by 2002:a17:90b:2587:b0:31c:c661:e4e with SMTP id 98e67ed59e1d1-324ed1ed238mr27715a91.33.1755718674513;
        Wed, 20 Aug 2025 12:37:54 -0700 (PDT)
Received: from lkmp.. ([49.37.163.128])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47640b191csm2911858a12.45.2025.08.20.12.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 12:37:54 -0700 (PDT)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: alexander.deucher@amd.com
Cc: Christian.Koenig@amd.com,
	Harry.Wentland@amd.com,
	airlied@gmail.com,
	amd-gfx@lists.freedesktop.org,
	corbet@lwn.net,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	rakuram.e96@gmail.com,
	simona@ffwll.ch,
	siqueira@igalia.com,
	skhan@linuxfoundation.org,
	tzimmermann@suse.de
Subject: Re: [PATCH] docs: gpu: Fix spelling mistakes
Date: Thu, 21 Aug 2025 01:07:38 +0530
Message-ID: <20250820193739.20263-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <BL1PR12MB514474E3D1951AA174431414F733A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <BL1PR12MB514474E3D1951AA174431414F733A@BL1PR12MB5144.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Got it, thank you for the guidance.

I will split this into a 2-patch series, one targeting amdgpu and one targeting drm, and send v2 accordingly.

Thanks,
Rakuram

