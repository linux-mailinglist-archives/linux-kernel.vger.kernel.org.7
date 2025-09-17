Return-Path: <linux-kernel+bounces-820649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 043DEB7D504
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E16C16C9B1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292592FBDF2;
	Wed, 17 Sep 2025 12:18:01 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568562FBDEA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111480; cv=none; b=oqmZyfAvsSqjoB/wu/yk3uWjzgHw7p6jtG+0E0QznDt/UQxKQsoV3e9G/FZN3msWAKSMQGSEMcg5PCTMtVrE0D5s37HXCLRFZGR+oh2Sa2hxd5d/xpx5pTJtDxSyEYDHc37bUmbqUytNrwR4C6Ya9jUdqsd+m0v1PT67KwjKvqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111480; c=relaxed/simple;
	bh=xO496SbJdfEtkCws1FbF83Z0k5siGcyeLu3sGNRxv3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRxh+lxF8OkWvheuDXXLgDY+7XFR5zEanJktta0n2eAKJ1vKV9wbNab1Vc6mZEdTNnkjGnJfXFKgDoESGLbyk3eGEClIKuyorUz1xwOBt9uyH2XFPyqeX1D3/NZ7QGR+bSOoJgVxzHgAsVO6D8+kWpe4tasba4Jc7FOvS6NG+SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-25669596921so68354855ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 05:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758111478; x=1758716278;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qh6YKvpPZBYGWe3t71eAmIBGoHDeTgKtZLWMs8wLOpw=;
        b=PnjJqtXQ5NFt6vtm3xhVULGZGTx2v/2qQdvjIZClESXL5jHMslO5HwJDT7wR1WkG+T
         N3sV7sY7kSPf3e79+Wory9EDZ4ueUHXyjP6HNMLJGOHTZfO/txiuAxxEnnmf8Rv4kAPW
         QJRx767TIvjRvYIlYzOB1wKOzfXv9KwaA/PIWbsqn3P+zdY2vpdGTc24JoKePoeX7TVu
         Qe3QrVMn6rEtR7thKKGhiYYrCkXg3UMyDKKdYzUdNGiOCpJerGJt8IkeEuxkydVZsPJe
         Xq/iiZ9o3q+PJuOPumCY8agD6+OBSPZ7m0f6t6dkMV9UZ/tY91FmrpCdZVdfifZSNGln
         mdXg==
X-Forwarded-Encrypted: i=1; AJvYcCUvDYDxQQ5Idx+50nRe+4z76HCT1Gil8SsHzl9PXqqxi1ab2LqoRHuHTT/bApNMHhM4D13Lzk6Uoc5bsEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG6B5qfj7hSYQFTMXNJ1YAJmXnApCuEP+kfC+gexzr70xNGSxe
	a0NkwKxqzKqNPA0Dm4Uwt16LQP2y7Kje7BqUTkuLVIY5wApK3S9UTzeb
X-Gm-Gg: ASbGncsLmuzSEaHehrF3A7lNaeU31mW/nCF8ZHppU/3UBB0kQLV8Mu2/9WE9lWZXcNO
	C5kWWzMZduEEIzdQI4aEX0qBnWS05i43MsUntmYjNEOdMs/1zahndcI2ICSOgnP7hMjtS3z3P2v
	LMPPCnPtG9wEaAhxE79tTeZo2IhfwSzaQ2Xw95/RvLoD8wUWbbF6B3ijMQMFZxEBm+Cf2E8HXQf
	kKlLtlOelgp7bHT6jfeUcwzSL8TG8UFcM/lq/Fmv8EJSwpXwHGRjfs1pI0GjGkH9a5gJUt+wEj3
	a05nYnIGxrQk3PCqAnWmyMdD+ob21DAjlhCOffa9ndY4BbOaU64Nyzqovy+aqsyDkajNVk4Vfur
	g3c1LmssRjbwvfEBT0YflHV4E+jUy3n4luq9HDHYZIPYBvy5XQQaf7VgLhvU3nIb8SIdN
X-Google-Smtp-Source: AGHT+IFpRhe8C2eqHknsEA/6M29fXs1KT5C9GKAJTC/cuu7MNv6bqjnevGYoR/ytjGumv0S3im1n5w==
X-Received: by 2002:a17:902:cccc:b0:263:3e96:8c1b with SMTP id d9443c01a7336-268138fdc59mr20672725ad.33.1758111478500;
        Wed, 17 Sep 2025 05:17:58 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-267c9996c93sm50384435ad.122.2025.09.17.05.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 05:17:57 -0700 (PDT)
Date: Wed, 17 Sep 2025 21:17:55 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Matthew Wood <thepacketgeek@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mario Limonciello <superm1@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND PATCH v7 1/1] PCI/sysfs: Expose PCIe device serial number
Message-ID: <20250917121755.GB792199@rocinante>
References: <20250821232239.599523-2-thepacketgeek@gmail.com>
 <20250915193904.GA1756590@bhelgaas>
 <aMnmTMsUWwTwnlWV@kbusch-mbp>
 <20250917083422.GA1467593@rocinante>
 <CADvopvYGtqLzm5m4yhXLih7SuSSuw4RtRhBCiXob+rXsMP5fSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvopvYGtqLzm5m4yhXLih7SuSSuw4RtRhBCiXob+rXsMP5fSA@mail.gmail.com>

Hello,

> Thank you all for the helpful responses!

Thank you for working on this! 

I am sorry that we took time to get this merged.

[...]
> I will prepare a v8 with that change, thanks again!

Feel free to add:

Reviewed-by: Krzysztof Wilczyński <kwilczynski@kernel.org>

While at it.

Thank you!

	Krzysztof

