Return-Path: <linux-kernel+bounces-752204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C2AB17276
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3131C22A7F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADF92D131A;
	Thu, 31 Jul 2025 13:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyXYIv2l"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF4F2D0C99
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753969853; cv=none; b=Yc70X8k2L30I0qIlEvGLJBoW59feRXYu/6SOARcP/0rRkHvMYmXO8Xdr+aDdi1lAEGjWhtyiWCeBgkTxMMT9fjK9bE2O7Uudm3gAOyGTX5dF4nm6+QwFaSNhyIEjZvDQkGzzEPdFbHNuV7WAlVufw5ifN0uJUZEcbZC3pAZ7pDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753969853; c=relaxed/simple;
	bh=wHephPRnWFJ/Wj+ePanHPAULwCYpiEvcIkvecMIKdO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bM0rwJQDVuRpeJCMI2RZBeBf7c41oPJ+YtIY5nv4ZJ3D7uC8RcT536QYHhIgy81DzqsbvA3dmpZGhfdN4yzQLQHCi4CTspXaUj4e8SF1AyQCoZ6+PeLPw7IcCBQ4E3n1FMMQTFI5XWMjHVinyxCqPnPpRt+HM9ZpuXtWZT7vlnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyXYIv2l; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-7075ccb168bso8126056d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 06:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753969851; x=1754574651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEQ1XoGm9eaZ2CQwlCxSmOHdyKgEeGnL9srDeytRVGU=;
        b=CyXYIv2lq0mlC5tfK74D0SiRs8KIAyQoP+HIpVShC8R2A9P92PT3kbu1UWotTUIYnV
         Tv0q3NoKmW51P9F6ATD/w0eORDV18ZE8yFx9IkxzZV07jHhcRMKX+j2iJLtI71Wk962Z
         nMSoB8F4KewslzStKBDbSHCVpj8RcJun3mZe0YOfVY4q5Oib2iVCDMke3/m05z4iB39h
         HOw7CVSxDxzRSvyN79H1bDjE1oSLwUbEjxFQMF9WSqfcHIYu1SpTHxqDg56uYVpIuB4P
         HjPhA5xnV+IcWH1RnyvhllJmHBMQG4JXf4SZfQhWn+8v29IfMvAnKuRrFMUxpJV3bMIb
         i7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753969851; x=1754574651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEQ1XoGm9eaZ2CQwlCxSmOHdyKgEeGnL9srDeytRVGU=;
        b=EvdnXzmjlccsC5GzEahUKS2UrgmjhnontQqHpCD9D3KldJS6VzNFFuBII5iOY7qbL0
         IwLtxxW6DPLegkR6ER4mFkKo78eDtm6hGMN+tEJpq12Th3qGMbqxXtFz6E+mpNC/S62U
         lmUEMlPpd8M2KFbLvJL7aVcxUueH96+35BVY7OaxFyWqAU/fKGmPRouAy978qzNkBRpd
         8YwFHuh+VH5llFWvzvzzRMjHklxjIufWaRl/gEPu0EVoiML31c+oBH5w6+ZCJu7Ys3/g
         hhFVdsck8su4Irf4mtfW2iXKiCLLfYBhs5hHwC5b2Kjm7PMLV7gm4n2B2ZKxmVQpoIhz
         i3Tg==
X-Gm-Message-State: AOJu0Yx+Wwt/4Eo65WXEsqkqy+yaxrYpIvOJC8zM+7H4SYQe8NTVaBIs
	Fhv23FnF8aG9nh0bAiD0g8ZrQRk0Vle0uOQyPm5Wy+wflbxPxMHQGa1k
X-Gm-Gg: ASbGncv3ZVLVmzDZ2IDu9lxzemvdddBZJ5uGDtDKWSe7BLKqbfc1G9B+Uwb7Rc1q+Z7
	d2pQMfhguv1+qsSVa1vUfImz93GZ4+a4NP6b9gb7FBNjTTOH44VyttCZrNvuKNKXt1S5FegHcyM
	tInBvtC1acg2R4G/Fu/DeX0kBOQOe2ADPmFOXdGMdyS6Hbz/FJCjq81A+PlIn77XhMY8zbewYNw
	YObRhVgc+cBwbfOBoNnl2Xjj8x2djtjupmppNhW3lpthu8q1DSovMQVlUSJdPLqMePrpeBvbMuZ
	oJ7wLLVSDWuGhwYbcKTIDkKaZRuulEYc5Fcu7xeQYOdZkAQerARRfRapafQqZ4FXbr8X+sRXtrn
	/YoDmQfFI0il6/Uh/D1ds0/GwLY9dNoBsoT0gHK0E+wedt144Ysk=
X-Google-Smtp-Source: AGHT+IH6+W3kKYsyKhKdjnmM6R+IzB/8tbDPac9jcn00m9evOh5Gm43paWEMVoBv6rMeNBc8x9iA3Q==
X-Received: by 2002:a05:6214:2626:b0:707:2ef6:c13e with SMTP id 6a1803df08f44-70767056804mr95728996d6.1.1753969850705;
        Thu, 31 Jul 2025 06:50:50 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077c716effsm7740906d6.0.2025.07.31.06.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 06:50:50 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	vivek.balachandhar@gmail.com
Subject: Re: Feedback on Patch Submissions
Date: Thu, 31 Jul 2025 13:50:22 +0000
Message-Id: <20250731135022.515348-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025073101-playful-easeful-3008@gregkh>
References: <2025073101-playful-easeful-3008@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Greg,

Thanks for your feedback — I understand your concerns now.

Apologies for the excessive revisions and resends during the merge window. I got too focused on addressing review comments quickly and lost sight of the timing and volume.

I'll hold off on resending until after the merge window closes, and will consolidate everything into a clean, single series.

Appreciate your patience, and thanks again for the guidance.

Best regards,  
Vivek BalachandharTN


