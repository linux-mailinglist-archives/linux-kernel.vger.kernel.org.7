Return-Path: <linux-kernel+bounces-805651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFEDB48BEC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F016163AF5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E9721B9FD;
	Mon,  8 Sep 2025 11:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SuGskaE2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C641D5150
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 11:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757330121; cv=none; b=qO8G2fC0TvWphgbXgRdhGQob6MGxoKemjN8EWr/LQToyFclGWk8qOEKCWUxWW3ryp6l6Co6NwOLEKYl/fge+g2dUZbmtcQS+35ZC3TESL/02x+uKo2PXmdJc3/miY814w1FxhphOAisfzAcVpsuLSWk0JvKzFAT5m7pQHPLSBkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757330121; c=relaxed/simple;
	bh=aUVE8FthtNrnN/ESZ4IO98xDT5XV5Larg3g6OfQcICU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMPkb5GGRCH+2aDHGzeDpkiR+sO3sT5IsusztKSHwl/5elOe/gbjNnas/2mkJS0OKCwTM6PEJjNSCm6XRpPCO0uuCN9ygscapOs8gpzZru5FSi3q5QCSnBbMs5FRnmezuH2HihvuwyuO+/CVIcdR8em956Cmu5GeQstYxLkq9z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SuGskaE2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757330118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wwUZv7xn5kwJDxXIChe0wNGvkZwPHl5q6JPSLW8gUe4=;
	b=SuGskaE2elTP0vbi4/V4CLe3jNsMQniv46Hzt7Swx9bekT7To9fZV0AMpz3ssqfvnHNhyN
	0LB1vlKznyFJBysIi9Za+ZEjicWTT8W8xr9vQ6MY3v2tyU46y+8nEVwOviVeZfD4WZQXzw
	5Nosmusis04mWa7TH+AeCL8V6BS5ZDo=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-CtHZE3mkN8ugSVb1vqDZvg-1; Mon, 08 Sep 2025 07:15:15 -0400
X-MC-Unique: CtHZE3mkN8ugSVb1vqDZvg-1
X-Mimecast-MFC-AGG-ID: CtHZE3mkN8ugSVb1vqDZvg_1757330115
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7725b4273acso9238918b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 04:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757330114; x=1757934914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwUZv7xn5kwJDxXIChe0wNGvkZwPHl5q6JPSLW8gUe4=;
        b=fHfkr37L3/kSxWZYwOd/nwgBZ45HZwJ4aSlvhQBcL12dsGCBuAxclNNJGr8hnr9Ldu
         GY7L4wniJHCQKzJ8urildP0259gNq0B+wpGwn3fcL/GOfe2sgW+X+Rsj8QWVVWfvkO2I
         tS8XtgQAMSrQz5d73+nmjmSUoBcnX+E2NfzXxOdX4G2CFD2kTOwKFKD42jUFk8y9sOYC
         6v7Oe+pwa+JKw91sHE1eOUYOdgPGVAAZvP4UwRTDISxd9Qh+giJBNFcIk79vUu/h0eNo
         4Q0PENuS0g3AufBCwv4gtNnd39CPrCEevmOvKGyNnGZ7a+MNDODbaVrB7nJoxNssq8y/
         jCQA==
X-Forwarded-Encrypted: i=1; AJvYcCVOmsVekc7+pwD7qFThxP/IAC+YtsWA0SxABOeX3AJOOqdUcHO8WCKD9Z8HK1AiRrYtuOj8N9fCqi20TbM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9IZnMp0IgoOtumuYlLqkx1anq14Jj4fClh+zBD89q44B4bFfz
	MWK7LJDTHAhfRdg2IuANQknxVZ/sXHqYhF0RhAYJgApXHzEewco6KEuSxPZ5B4zCEws05JZ4RVn
	dQCaKZowv65g3WZGRGzPhnASr79pOHSegP0CD3zQwfeBRLSeG3rXG4om336iB8YvioA==
X-Gm-Gg: ASbGncuwgU6svTAGSlteMLTp+EwWxUuI2cdbF3JH3WC4nQKdUqTrZ2HCYD5F1S/3hXz
	bKLAd34yx5drGJOh9mHJRqWKVbUnLuH+6xamtL08jedr20qxUEUKv8n/VZNX8QGW71zSBXVH1Z0
	6lu2OpETAPNUBydW9rx/jYFyKnNwGlmpIogRd2XmqRd1OgryOzDmApDxUOAQTxzMF8HXP3/UidP
	QnbR/ikVL5Nb3Kj+8/C42qn/N/0l3VYFRx2K78fdSnE+gm5uv4SQuouj+Ao4wzz6xvp0/Ug9Mut
	B8UewHYKEzO5O4Z8EvkCzzCquYS01iI=
X-Received: by 2002:a05:6a00:4613:b0:772:5b74:c26e with SMTP id d2e1a72fcca58-7742dea660amr11162779b3a.18.1757330114613;
        Mon, 08 Sep 2025 04:15:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1AQ3ExSzLUZMdMo+aC42rYKm4I5V31Fv7OTUPdi28epWE4qludHltIl7qqNhPZKbMu+fugA==
X-Received: by 2002:a05:6a00:4613:b0:772:5b74:c26e with SMTP id d2e1a72fcca58-7742dea660amr11162739b3a.18.1757330114113;
        Mon, 08 Sep 2025 04:15:14 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e1ca7sm29403639b3a.71.2025.09.08.04.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 04:15:13 -0700 (PDT)
Date: Mon, 8 Sep 2025 19:12:07 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ima: don't clear IMA_DIGSIG flag when setting non-IMA
 xattr
Message-ID: <53wb5tzech2k4k25xy2heq7ohmp2elw2a7l4x3nfk6fajfydur@5thsinydau5x>
References: <20250902042515.759750-1-coxu@redhat.com>
 <d252b04934908e7e65a3299bfeffc282c7b0b12f.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d252b04934908e7e65a3299bfeffc282c7b0b12f.camel@linux.ibm.com>

On Thu, Sep 04, 2025 at 10:41:42PM -0400, Mimi Zohar wrote:
>On Tue, 2025-09-02 at 12:25 +0800, Coiby Xu wrote:
>> Currently when both IMA and EVM are in fix mode, the IMA signature will
>> be reset to IMA hash if a program first stores IMA signature in
>> security.ima and then sets security.selinux for a file. For example, on
>> Fedora, after booting the kernel with "ima_appraise=fix evm=fix
>> ima_policy=appraise_tcb" and installing rpm-plugin-ima, reinstalling a
>> package will not make good reference IMA signature generated. Instead
>> IMA hash is generated,
>>     # getfattr -m - -d -e hex /usr/bin/bash
>>     # file: usr/bin/bash
>>     security.ima=0x0404...
>>
>> This happens because when setting selinux.selinux, the IMA_DIGSIG flag
>> that had been set early was cleared. As a result, IMA hash is generated
>> when the file is closed.
>>
>> Here's a minimal C reproducer,
>>
>>     #include <stdio.h>
>>     #include <sys/xattr.h>
>>     #include <fcntl.h>
>>     #include <unistd.h>
>>     #include <string.h>
>>     #include <stdlib.h>
>>
>>     int main() {
>>         const char* file_path = "/usr/sbin/test_binary";
>>         const char* hex_string = "030204d33204490066306402304";
>>         int length = strlen(hex_string);
>>         char* ima_attr_value;
>>         int fd;
>>
>>         fd = open(file_path, O_WRONLY|O_CREAT|O_EXCL, 0644);
>>         if (fd == -1) {
>>             perror("Error opening file");
>>             return 1;
>>         }
>>
>>         ima_attr_value = (char*)malloc(length / 2 );
>>         for (int i = 0, j = 0; i < length; i += 2, j++) {
>>             sscanf(hex_string + i, "%2hhx", &ima_attr_value[j]);
>>         }
>>
>>         if (fsetxattr(fd, "security.ima", ima_attr_value, length/2, 0) == -1) {
>>             perror("Error setting extended attribute");
>>             close(fd);
>>             return 1;
>>         }
>>
>>         const char* selinux_value= "system_u:object_r:bin_t:s0";
>>         if (fsetxattr(fd, "security.selinux", selinux_value, strlen(selinux_value), 0) == -1) {
>>             perror("Error setting extended attribute");
>>             close(fd);
>>             return 1;
>>         }
>>
>>         close(fd);
>>
>>         return 0;
>>     }
>>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>
>Thanks, Coiby.  Agreed, the ability to clear the IMA_DIGSIG flag should be
>limited to security.ima xattr and probably security.evm xattr.  Writing other
>security xattrs should not affect the IMA_DIGSIG flag.

Thanks for confirming it!

>
>Even without an IMA appraise policy, the security xattrs are written out to the
>filesystem, but the IMA_DIGSIG flag is not cached.

It seems I miss some context for the above sentence. If no IMA policy is
configured, no ima_iint_cache will be created. If you mean non-appraisal
policy, will not caching IMA_DIGSIG flag cause any problem?

>
>Please document the tristate values:
>0: clear IMA_DIGSIG
>1: set IMA_DIGSIG
>-1: don't change IMA_DIGSIG

Addressed in v2. Thanks for the suggestion!

>
>> ---
>>  security/integrity/ima/ima_appraise.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
>> index f435eff4667f..fc82161f8b30 100644
>> --- a/security/integrity/ima/ima_appraise.c
>> +++ b/security/integrity/ima/ima_appraise.c
>> @@ -708,7 +708,7 @@ static void ima_reset_appraise_flags(struct inode *inode, int digsig)
>>  	set_bit(IMA_CHANGE_XATTR, &iint->atomic_flags);
>>  	if (digsig)
>>  		set_bit(IMA_DIGSIG, &iint->atomic_flags);
>
>This matches both -1 and 1.  Test "digsig == 1" here.
>
>> -	else
>> +	else if (digsig != -1)
>
>and test "digsig == 0" here.
>
>>  		clear_bit(IMA_DIGSIG, &iint->atomic_flags);
>>  }
>>
>> @@ -794,6 +794,8 @@ static int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
>>  		digsig = (xvalue->type == EVM_IMA_XATTR_DIGSIG);
>>  	} else if (!strcmp(xattr_name, XATTR_NAME_EVM) && xattr_value_len > 0) {
>>  		digsig = (xvalue->type == EVM_XATTR_PORTABLE_DIGSIG);
>> +	} else if (result != 1) {
>
>The "if (result != 1)" test is redundant.

I've fixed them in v2. Thanks for reviewing the patch and correcting my
careless mistakes! I'll check if my mind is in a clear thinking state
next time.


>
>thanks,
>
>Mimi
>
>> +		digsig = -1;
>>  	}
>>  	if (result == 1 || evm_revalidate_status(xattr_name)) {
>>  		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);
>

-- 
Best regards,
Coiby


