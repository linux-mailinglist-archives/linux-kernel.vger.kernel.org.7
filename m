Return-Path: <linux-kernel+bounces-781116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D277B30DB5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A901CE1B99
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 04:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A43026CE2A;
	Fri, 22 Aug 2025 04:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AK+95ps9"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C3213A3F7
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755838220; cv=none; b=Lh5WYM3XlH/9XgcuPxTnA50tDPYoRsFM1cxYeTAlm1zLfkr+1iikjXirino1Pmqi1oboqPUZpmKOC7jXz4dQj2sZ/mC4DMhQJyeuZBKua6I5gJWFWArk6LX3l7ZLMRWSGXfsK7mNRB/W8/QhjmFSo/SdwxE8Ri95jtNz1ft+Pv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755838220; c=relaxed/simple;
	bh=7MLJMc8p0GhX1StEfjqpfk5hw9LwYycmmmOXaAEQznw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2DNGLaqg6iJ2PiYgpLOVBIFxBaQerIQUyVgreaAk5k/f6dqIQieogYUoxc4idRPA315iY1BJFkR5feoDq3j8YOSMNWe/3vh72iJh+1m1a3mfz+MmK5r4KieJYfRi2T2/wwrvzzj22ajCEjwIz2i/TzzStKLiRPNFQzQfH3NlV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AK+95ps9; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb731ca8eso274295966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755838217; x=1756443017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEIz24p5TaTxWLmelV42u1VEA76tZGIfbFJlyF85/YQ=;
        b=AK+95ps9gAWnHafKQ/z0Pe8DFyHs3EcMYDdtxXS+aMFTP9IMxW9sAmUPmTfAwPtMqM
         7qy9WOg0E/Nyb+LwgmIzYIFg+4vEzz/vsImbMao4ojdX+8OEhkQezSnyeo+98ySmOF+2
         cj8LJe5JhgzA7JOBIG1Fb3lJ9J4up5hxHgQTUJ+8ZKTTqdOke7okPmLEHO8qM/HVNDVf
         us4s61I6EB+HK0BVfnv2u46UN3K3dtbad/Upxaru4EtVZ0jBjT4mMOamuL6sBZ6oDlNk
         Ll+xM8suvdjtS0lFSq7u7xylcLpUZ46dSdDuoEUMOlu0MCv244EaDcQS7SwRc5IU0BBE
         jFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755838217; x=1756443017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEIz24p5TaTxWLmelV42u1VEA76tZGIfbFJlyF85/YQ=;
        b=J2geyPrsNXaszX2iAdcOd1wNCXCQczLj4foMXBUSxVQhWi3Umc8Fbv+vv7eI0vCoFV
         PMIR4gEiRKmzR9R5uFxTXWxDD38cTUJPLc/CICO9PUgcRvg5kkEZ5LwDTHDKixq4N2QG
         AZ7nGMPE0ExwmqYsfCvG/3seYHiBzJ2CIO8+dfg2qzK56K3Lc7B/xy8Zf3mxbyjjO2hh
         m308ZJOe6Hn9unP8arCor2yfboetWRP8Y/ZfcIEFt1vqGaZ9FGAc/nF+J6dE54OgfW/f
         GEtqC7zymfV9ONHiVTIt4ZYHluu12/pCgJ5+JrpEVjl9WPdKO/q0/wyZdEju+ASkiPyy
         mJNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUVbOHOiqeiDaUnmIHqnk1+9EenL+IYJwJ4f0Q9v3LAmjAUHn13SPAl7DmtPji6JyZglln+79i/xAxlPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YysLdJy//YC81qx4LW0BIgWOT0uHwTFyqVD/Z8k7R9HXVA6MZYw
	w9koW4iGZMKeAZ2UQjJGl9iXyV0gMjT0nuW4sfJy8Ua6/QEyFO5Z5qj1
X-Gm-Gg: ASbGncsIdBfv8x7NdAd7kdJlS+6W8PvJl+PTTjvBpXy3TnXzb6nfmniAM6bFkiLqxX2
	w37MxUXLWqmEl5U4QZ/RPawe6dEMtvdkIsEb4Vj1m3qhvzog8sq3NAhM8P/kwQsYxUNEJDLG1Nd
	1Si+IRis4K0740aZj271TCYqm5RDHQrIKOh8Xwqc5cJEcUgUe1WpiFI4WJ/3/npk6pyGQekIcsp
	qrYB/0ChrQBxfV3TvkP0GqnrPY3AZaLU8dL0q5UWzM0y6EqcdNrUM1ugxFuHBsYBYwWfJrPro/a
	eoEfp2IfZQzRvKSTd2bo4HohS1FItMIoszk6RxeQY37/N0G1etelIl0Y9HUH9c0tBCacY7jdfTX
	s9WcbzD58+k7brdgC/QORsw==
X-Google-Smtp-Source: AGHT+IENDR0qdwLnj2nmpmUrcCdaDleQNKrX2hEXY1PM8fVU79lv6FvuC4p+RFRlolkWHOy6tNGDlg==
X-Received: by 2002:a17:907:805:b0:afd:d993:9f2b with SMTP id a640c23a62f3a-afe29638000mr141949066b.65.1755838217077;
        Thu, 21 Aug 2025 21:50:17 -0700 (PDT)
Received: from masalkhi.. ([61.8.144.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded4c993csm529951866b.91.2025.08.21.21.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 21:50:16 -0700 (PDT)
From: Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
To: nichen@iscas.ac.cn
Cc: abd.masalkhi@gmail.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: eeprom/m24lr: Remove unneeded semicolon
Date: Fri, 22 Aug 2025 04:49:07 +0000
Message-ID: <20250822044907.1190-1-abd.masalkhi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821081804.3168680-1-nichen@iscas.ac.cn>
References: <20250821081804.3168680-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Chen,

Thank you.

Reviewed-by: Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>

-- 
Best Regards,
Abd-Alrhman

