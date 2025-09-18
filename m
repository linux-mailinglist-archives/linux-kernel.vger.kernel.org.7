Return-Path: <linux-kernel+bounces-816137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9959FB57008
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D9D41719C3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 06:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526A32773C3;
	Mon, 15 Sep 2025 06:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUgFmsxP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF30E207A38
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757916320; cv=none; b=h+KlG6+UYomEC4qAgdCN/aZQXyvqFGz5EigitN4vqkkv0nVDmjcD/vtbQL1L2eWWbMByhhczdiiH2nt1OMI/ZPjpZZnb/QfdEV5sD2uPx7QyzLlEaqxUau2lsEPvA023EmAn3Of6l2HeXbvSmQgnTvgnHK3XOiIWWTz6vPbd/dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757916320; c=relaxed/simple;
	bh=FjnuknUKHafj9VjcTmGKowDO4oahvWxzLheWbZonOt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyLpd+42sFd8KL1YinJ2qFU9nstpxdov4ER+JcH0UHmyZ320WbpqsTRONEAuEkT5Re1+DDbluwmND8b4SOGjnvo4iEr7s3dG8eGwM/4vmq9XHdW6Ec8xEEpBL24zNQzPHXmMn342Bb2FOMIWFME+VaCbzP5knD9bKmrK3s5ZkVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KUgFmsxP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757916317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=omBBC34VXd5M1CEthfLS/UAjyzULL/tObmzB8px4Cho=;
	b=KUgFmsxPbGNPkbGtA/Ez6FMl1+i5IN50kJQCqdtg5twtLlgDPz31W4pmkHJv7dNibqq9WT
	X79qOMXWph5c+ULQX6cT+/a4/ZYj0AhKxzJXsRbWgfkQSBqpRNBA7o9Ro1BU9r9PUPqc5G
	fpr+yzYheA6RcWIx3eBSTaocUEiTNi4=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-HYwBbPZrNEeysXt6WS_Bmw-1; Mon, 15 Sep 2025 02:05:15 -0400
X-MC-Unique: HYwBbPZrNEeysXt6WS_Bmw-1
X-Mimecast-MFC-AGG-ID: HYwBbPZrNEeysXt6WS_Bmw_1757916315
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4e63a34f3fso2440376a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 23:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757916314; x=1758521114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omBBC34VXd5M1CEthfLS/UAjyzULL/tObmzB8px4Cho=;
        b=r2txOBVuUknTuT2nz1vrcvGy4biDwkHtYg5Pn53I/UZ3UJP7+y4mLZjHryGJRoakj9
         sdsfb1HVVWLU7XQxIMRgUI7/gvbwVmf71Cg1CjYvXI0VqaM0oQe5Q1UYju2tfpMoVKk8
         Z4joMIGeDcUcrWqh/YhP3GVhDTht8yLC6YDL5gNdgzYxNIgSF0cI1wbNV0Zdmul0Sazg
         Wl3l4vTRU7PPtN0vJFil5LUtg4ADufrT9Yj985pjZ97/EwzPvnefPmphfbpuLSRGMkEc
         5XlNpZrRXamnXTjnr7BbUngxdQ/O7REfs1udOiy4XB+/e4ipkdoW+mR/vU9a8SJg2IJQ
         j8QA==
X-Forwarded-Encrypted: i=1; AJvYcCU5oDpU2JKK23lbb/VOodh3ksdlg8tRmva90OPyj4Y12UjvsJZqF3/w/95qgrjTxItZQ3HqxzIrDqblsOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSNf5cWTPiNAgkFxpYQIQ9F9BuTfnbzIv/wCm0u6ziearmMClN
	XuRbsEfJLZS5hKqp2qRb//Pgs9KXr1Z8G2oQf3EiWWgk3BjgKUExbef9D2Mr6U139lq1fCNG9+b
	Y3RRQwPnVAQulXbgGutLatW9WITbJmttl6visELN02IML9vD9IxjQ5qS1cDL/nc15Xw==
X-Gm-Gg: ASbGncvJ5nedJM317UIsHvNRMA+ZryDYRnviwI5ZlNeXXktHq9kiiqXaCn7xBDBENP0
	YRJSESqiUv1TonC7sii6i3w80XEp39sNAQ/Tr3F3EL0JE57VrG4y5YxaSh8gDmw1tEtP5dsN0IH
	RM0XjfMPcEq9l6au2jYja+BTMGRpo+J89/tnojyWgqdOgNtOwnmk4EdNg0wpdXxfCrFovF30bhe
	6G13X3m3khnS5BNk80KsWZfDzhV/VSaw+niAnEfXCw47yvkYfHvbMvJKUee2NWZYp8SjAqcO1JF
	WisEVtAm9EP6N9HXqodAYF1jf880qgg=
X-Received: by 2002:a17:903:37cd:b0:25b:f1f3:815f with SMTP id d9443c01a7336-25d2782cda6mr166987695ad.58.1757916314542;
        Sun, 14 Sep 2025 23:05:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNlG6tjmW8hOH++0qfJ78+vVgyjSBUaQc7oR1me/YHP9gwQwOcHBaCT0XwJ/bVU3GcEaMzkA==
X-Received: by 2002:a17:903:37cd:b0:25b:f1f3:815f with SMTP id d9443c01a7336-25d2782cda6mr166987255ad.58.1757916314118;
        Sun, 14 Sep 2025 23:05:14 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-264277e8bc2sm35628675ad.138.2025.09.14.23.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 23:05:13 -0700 (PDT)
Date: Mon, 15 Sep 2025 14:03:32 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ima: don't clear IMA_DIGSIG flag when setting non-IMA
 xattr
Message-ID: <asadtbf7itw2343rjwvqfdvhmofhu7k6n4vsos2lojt6gqtudv@l7cgdsfbuuku>
References: <20250902042515.759750-1-coxu@redhat.com>
 <20250908105825.1573222-1-coxu@redhat.com>
 <7790048d4dc468792b428e80ceae7261a97a896d.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <7790048d4dc468792b428e80ceae7261a97a896d.camel@linux.ibm.com>

On Wed, Sep 10, 2025 at 08:21:03AM -0400, Mimi Zohar wrote:
>On Mon, 2025-09-08 at 18:58 +0800, Coiby Xu wrote:
>> Currently when both IMA and EVM are in fix mode, the IMA signature will
>> be reset to IMA hash if a program first stores IMA signature in
>> security.ima and then sets security.selinux for a file.
>
>The problem description should be generic.
>
>-> and then writes some other security xattr for the file.

Good advice! I've applied it to v3 with a slight change,
"... then writes/removes some other security xattr" in v3,


>
>Start a new paragraph here for the example.
>> For example, on
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
>
>Start a new paragraph here, adding a sentence describing the solution to the
>problem. For example,
>
>Prevent replacing the IMA file signature with a file hash, by preventing the
>IMA_DIGSIG flag from being reset.

Thanks for the suggestion, applied to v3.

>
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
>Thanks, Coiby.  The updated patch looks good.  Have you looked at the other
>calls to ima_reset_appraise_flags() to make sure they don't need to be adjusted?

Great question! I've updated the other two places in v3 which can
address two additional cases,
- remove xattr like security.evm
- set/remove ACL

Note I tried to write a C program to set/remove ACL but somehow the C
version of "setfacl -m u:test:r" always lead to "acl_set_fd: Invalid
argument". I bypass this issue by setting system.posix_acl_access xattr
directly. We can get the value by "getfattr -m system.posix_acl_access
-d -e hex" after "setfacl -m u:test:r /usr/sbin/test_binary".

>
>thanks,
>
>Mimi
>
>> ---
>>  security/integrity/ima/ima_appraise.c | 15 +++++++++++++--
>>  1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
>> index f435eff4667f..4e4750ea41ad 100644
>> --- a/security/integrity/ima/ima_appraise.c
>> +++ b/security/integrity/ima/ima_appraise.c
>> @@ -694,6 +694,15 @@ static int ima_protect_xattr(struct dentry *dentry, const char *xattr_name,
>>  	return 0;
>>  }
>>
>> +/*
>> + * ima_reset_appraise_flags - reset ima_iint_cache flags
>> + *
>> + * @digsig: whether to clear/set IMA_DIGSIG flag, tristate values
>> + *          0: clear IMA_DIGSIG
>> + *          1: set IMA_DIGSIG
>> + *         -1: don't change IMA_DIGSIG
>> + *
>> + */
>>  static void ima_reset_appraise_flags(struct inode *inode, int digsig)
>>  {
>>  	struct ima_iint_cache *iint;
>> @@ -706,9 +715,9 @@ static void ima_reset_appraise_flags(struct inode *inode, int digsig)
>>  		return;
>>  	iint->measured_pcrs = 0;
>>  	set_bit(IMA_CHANGE_XATTR, &iint->atomic_flags);
>> -	if (digsig)
>> +	if (digsig == 1)
>>  		set_bit(IMA_DIGSIG, &iint->atomic_flags);
>> -	else
>> +	else if (digsig == 0)
>>  		clear_bit(IMA_DIGSIG, &iint->atomic_flags);
>>  }
>>
>> @@ -794,6 +803,8 @@ static int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
>>  		digsig = (xvalue->type == EVM_IMA_XATTR_DIGSIG);
>>  	} else if (!strcmp(xattr_name, XATTR_NAME_EVM) && xattr_value_len > 0) {
>>  		digsig = (xvalue->type == EVM_XATTR_PORTABLE_DIGSIG);
>> +	} else {
>> +		digsig = -1;
>>  	}
>>  	if (result == 1 || evm_revalidate_status(xattr_name)) {
>>  		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);
>

-- 
Best regards,
Coiby


