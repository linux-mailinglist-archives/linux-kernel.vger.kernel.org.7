Return-Path: <linux-kernel+bounces-821848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 454B4B826F0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED52C17B68A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 00:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212CD1E130F;
	Thu, 18 Sep 2025 00:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzGvJlF3"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846091DFD96
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 00:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758156378; cv=none; b=nuN2fG5/pHEWUVmjnKufqsQrwqbCC97/5CypUzdYcNRPeV0/ixQWkKIw662HwpYEhBKkCMPIkxtiVtNBEZaVdSreVMdpaIxx0/LYl+AOU/WWK7geVvQxxcLcw+H/rpLILMi5ltmvTBlHLZj+5Ae3KSxYJZGJc9xn45XTE+mi/EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758156378; c=relaxed/simple;
	bh=UIo7RA/G/xDD02JBTiyBlQlJJd9IfyisvvvnbSKMNJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grCnLt8nKCotH9VNFhkVqvbE5oWwy/FQi08dlaTLUecIRnflIezQPfjMVAw8FK3bCTB00+Y3ihjsl8VI+msY0wMo/opN4J1ZrR298kamuVu/SLY18hJe1Wso3nuFYvZ4QSQDd8cXzRsCTBlf2ty33o5J+J0fzCutDQ92F+dsZZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzGvJlF3; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b0787fa12e2so61758166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 17:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758156375; x=1758761175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScdSoNWwYp7Lx1FqF0sJinLc5HuMMzMbeEOteqLeKGY=;
        b=KzGvJlF3KPV470aj9p2+WGc+dHQyYumQ/n1JBBocmuZJA49YLeiUqmwy+/yYPZgQZj
         ssXCb7z6YgYiOutrT3AfsrRikN0B83+7ruvziWNhCwsz2ELTIiizmfls7PvsFdkvcJLT
         qpJdXp6xZhBTLS5nekg+F1LDSdhm19EysHMtk07fabj1P6oLuOyCMfvOGen6jT1eBwbP
         6pMnjF6KJT+0XEj91pCTwQujjt7F6ghOtnCnJ+EU2+tXugoJTsFgk+QsjwfhKOKRRjgu
         d9FePQZs61kpvgUTD0qeflLnFiVK5p7eAvAv3yf1sOrJiE6TsrG+zJ2UIlYBCl4PmRtc
         hKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758156375; x=1758761175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScdSoNWwYp7Lx1FqF0sJinLc5HuMMzMbeEOteqLeKGY=;
        b=LIDYzfUX+UGIYpb/GKsgS74NW4nR1b8U2kVJkQzdkN81GMrwLBnankwAlwJ8Ap9ndC
         sW7eizJNikjbtmEf+voT3CXdwMvAqDXgQcspy1Ebvli9sUfDEJ6xSziLJC8CzMNNo7W3
         xutchoofX10D7yxNhne+mEkqHHMaf7gHqunOuVadSPcFco3BjtpExhFSVR9AEWFjcb77
         xy3UvnQL2SOIy/lnFURQPhwod7D6+CwUU0nFlOWGyK6+03xcEDGrmRAgQ4DW0NjW/w4s
         pUjusfHXLG1yT4OXrc/iOs2cAO5t5LziXy6auxAf82Z85bSTcbtGbH1fN6EVjYCFJNPU
         DnrA==
X-Forwarded-Encrypted: i=1; AJvYcCVDdJoa55paCC2zfglCoa7ZPwTnwMA+7YxYy2NBu0jCxIyH3yFTq1fqyvBCCz2WFvCT1Dqx8TVEt5egkuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB8KskLm9n5mEbkbrMNDt836rdRgs6oRZQjCuQaztKV2csaTm2
	hrpn8YmZSP4tBvPDdzqRpzT5+QIf2APM9uJ5Yz9H69ikFcQHO3SGgp/J
X-Gm-Gg: ASbGncvRxE6sfHmHg5PbQ5CpF11cspX1Aqr9sBHa5NdE+b4P8bWrt49j4JwZ9FYzUB1
	VwhPeKmZLTQITnqo3phhtpamBOe5IKNaNOc2EXKMgRfKrBV1vPtCYw+NtmdnZ1MTty25m5myYph
	Oige0dL8ajjzcbZ6fhbk5DaCfT9Kfsr4Re1i8eJ5+SXD0lu1tYcSd1c0hgP9KqnBgeDxQTOtOmv
	yLDOHV9mNW9j44EwvIQM83+XrMnMGz+8zgkPqcjlajzmhIbaUnXazAPG+qtMSq3JN2SCTnOlWl9
	cEIJlVAxUKEWZFvGy2z9CZWcVWBr5+bDTbT6ydP3TMqfBzg8c6ny1fMogQx980RZJw6eFwd+E9D
	w/R+TMsEJ3L2Oa0a7t3qnXyjYkGAIK5i9n33Vyg==
X-Google-Smtp-Source: AGHT+IGtolM3WpmMOfPkC5aQN2+QGXojyD9zctBgGDhejOP10KXv+fVObxP+zNTcUHL0l2vGVmYa+w==
X-Received: by 2002:a17:907:7291:b0:b07:c28f:19c8 with SMTP id a640c23a62f3a-b1bb7d419c3mr514517266b.30.1758156374473;
        Wed, 17 Sep 2025 17:46:14 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b1fd271ead3sm73266366b.101.2025.09.17.17.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 17:46:14 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: brauner@kernel.org
Cc: amir73il@gmail.com,
	axboe@kernel.dk,
	cgroups@vger.kernel.org,
	chuck.lever@oracle.com,
	cyphar@cyphar.com,
	daan.j.demeyer@gmail.com,
	edumazet@google.com,
	hannes@cmpxchg.org,
	horms@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	kuba@kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	me@yhndnzj.com,
	mkoutny@suse.com,
	mzxreary@0pointer.de,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	tj@kernel.org,
	viro@zeniv.linux.org.uk,
	zbyszek@in.waw.pl
Subject: Re: [PATCH 17/32] mnt: support iterator
Date: Thu, 18 Sep 2025 03:46:06 +0300
Message-ID: <20250918004606.1081264-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250910-work-namespace-v1-17-4dd56e7359d8@kernel.org>
References: <20250910-work-namespace-v1-17-4dd56e7359d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Move the mount namespace to the generic iterator.
> This allows us to drop a bunch of members from struct mnt_namespace.
>                                                                       t
> Signed-off-by: Christian Brauner <brauner@kernel.org>

There is weird "t" here floating at the right

-- 
Askar Safin

